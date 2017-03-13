# Burning Flipside Developer

This repo includes helper tools to allow you to easily create a development sandbox of Burning Flipside web applications.

This repo uses Docker Compose so you should have Docker installed on your workstation before you begin.

## If your workstation runs Windows

To run the latest docker on window requires Windows 10 Professional.  

If you are running another version of windows we recommend creating a linux virtual machine to work from.

## If your workstation runs OSX or Linux

You can run the latest docker with little restriction.

You still might find advantages to working in a virtual machine.

## Creating a Virtual Machine

We recommend creating a virtual machine following these instrcutions.  
https://bhedana.gitbooks.io/burner-code-school-sandbox-provisioning/content/


## prerequisites
1. [Install Docker](https://www.docker.com/products/overview)
1. [Install Docker Compose](https://docs.docker.com/compose/install/)


## setup
1. [Sign up for GitHub Account](https://github.com)
1. [Fork our repos](https://help.github.com/articles/fork-a-repo/)
  * https://github.com/BurningFlipside/CommonCode
  * https://github.com/BurningFlipside/Profiles
  * https://github.com/BurningFlipside/Registration
  * https://github.com/BurningFlipside/SecureFramework
  * https://github.com/BurningFlipside/ThemeRegistration
  * https://github.com/BurningFlipside/Tickets
  * https://github.com/BurningFlipside/VolunteerSystem
1. clone this repo to your workstation
  ```
  git clone https://github.com/BurningFlipside/DevSandbox
  ```
1. run setup helper script
  ```
  cd DevSandbox
  ./setup.sh
  ```

## spin up services

docker instances will run your services but will read source from local repos in ./src/*

change source code and refresh browser to immediately see your changes

if you have mysql, ldap, or mongo database services running on your development machine you will need to stop those services while docker-compose is running.

```
$ docker-compose up
```
now point your web browser to https://localhost:3300
open up repos in src/* to make changes

## spin down services
```
$ docker-compose down
```
