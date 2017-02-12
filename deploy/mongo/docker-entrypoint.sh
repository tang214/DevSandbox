#!/bin/bash
set -eo pipefail
shopt -s nullglob

# if command starts with an option, prepend mongod
if [ "${1:0:1}" = '-' ]; then
	set -- mongod "$@"
fi

# skip setup if they want an option that stops mongod
wantHelp=
for arg; do
	case "$arg" in
		-'?'|--help|--print-defaults|-V|--version)
			wantHelp=1
			break
			;;
	esac
done

_check_config() {
	toRun=( "$@" --verbose --help )
	if ! errors="$("${toRun[@]}" 2>&1 >/dev/null)"; then
		cat >&2 <<-EOM

			ERROR: mongod failed while attempting to check config
			command was: "${toRun[*]}"

			$errors
		EOM
		exit 1
	fi
}

# allow the container to be started with `--user`
if [ "$1" = 'mongod' -a -z "$wantHelp" -a "$(id -u)" = '0' ]; then
	_check_config "$@"
	mkdir -p /data/configdb /data/db
	chown -R mongodb:mongodb /data/configdb /data/db
	exec gosu mongodb "$BASH_SOURCE" "$@"
fi

if [ "$1" = 'mongod' -a -z "$wantHelp" ]; then
	# still need to check config, container may have started with --user
	_check_config "$@"

	# if seed data volume is mounted
	if [ -d /docker-entrypoint-initdb.d ];then

		mongod --dbpath /data/db >/dev/null 2>&1 &

		RET=1
		for i in {30..0}; do
			while [[ $RET -ne 0 ]]; do
				echo "=> Waiting for confirmation of MongoDB service startup"
				sleep 5
				mongo --eval "help" >/dev/null 2>&1
				RET=$?
			done
		done
		if [ $RET -ne 0 ]; then
			echo "=> MongoDB init process failed."
			exit 1
		fi

		# ADMINUSER=user
		# ADMINPASS=pass
		# echo "=> Creating an admin user in MongoDB"
		# mongo admin --eval "db.createUser({user: '$ADMINUSER', pwd: '$ADMINPASS', roles:[{role:'root',db:'admin'}]});"

		for f in /docker-entrypoint-initdb.d/*; do
			filename=$(basename "$f")
			extension="${filename##*.}"
			filename="${filename%.*}"

			OIFS=$IFS;
			IFS="-";
			db=($filename);
			IFS=$OIFS;

			mongo=(mongoimport --db ${db[0]} --collection ${db[1]} --drop --file $f)

			case "$f" in
				*.sh)      echo "$0: running $f"; . "$f" ;;
				*.js)      echo "$0: running $f"; "${mongo[@]}"; echo ;;
				*.json)    echo "$0: running $f"; "${mongo[@]}"; echo ;;
				*)         echo "$0: ignoring $f" ;;
			esac
			echo
		done

		mongod --dbpath /data/db --shutdown >/dev/null 2>&1 &
		sleep 5

		echo
		echo 'MongoDB init process done. Ready for start up.'
		echo
	fi
fi

exec "$@"
