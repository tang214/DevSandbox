#
# ./swagger
#

start api documentation browsing container at http://localhost:3500
```
docker run --rm -it\
    --name doc.burningflipside.local \
    -p 3500:8080 \
    -v $HOME/src/FlipsideDeveloper/deploy/swagger/data/config:/editor/config \
    -v $HOME/src/FlipsideDeveloper/deploy/swagger/data/docs:/editor/spec-files \
    swaggerapi/swagger-editor
```

open http://localhost:3500
