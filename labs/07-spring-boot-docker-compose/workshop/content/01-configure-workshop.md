+++
title = 'Running Spring Boot with Docker Compose'
+++

This is especially useful for external dependencies, such as a database.

Please review the [detailed instructions in the Educates documentation](https://docs.educates.dev/custom-resources/workshop-definition.html?highlight=compose#enabling-ability-to-use-docker).

## Run the example

This example shows how to bootstrap and use a Spring Boot application with a backing MongoDB service
using Spring Boot Docker Compose support in an Educates lab.

1. Review the codebase.
   You'll see it is a GraphQL application that has a MongoDB backend.

1. Review the docker compose file.

   ```editor:open-file
   file: ~/exercises/compose.yaml
   ```

   You can see that MongoDB is configured as the backing service for
   the Spring Boot app.

1. Run the Spring Boot application in the terminal:

   ```dashboard:open-dashboard
   name: Terminal
   ```

   ```shell
   > ./gradlew bootRun
   ```

   You will see a standard Spring Boot output,
   but will also see the boostrap of a mongo db service:

   ```shell
   ...
   2024-01-26T04:59:09.335Z  INFO 1592 --- [utReader-stderr] o.s.boot.docker.compose.core.DockerCli   :  Container exercises-mongodb-1  Healthy
   ...
   ```

## Configure your own

Add the following to your workshop definition to enable docker.

1. Update `workshop.yaml`.

   Add the following to `session.applications` section of your workshop
   definition at `lab-xyz/resources/workshop.yaml`:

   ```yaml
   spec:
     applications:
       session:
         docker:
           enabled: true
           storage: 5Gi
           memory: 2Gi
           socket:
             # you must have this to enable docker ps, etc.
             enabled: true
   ```

1. Notice the storage and memory parameters.
   You will need to tune these according to the combination of docker containers
   you will have configured in your spring boot application compose services.

1. Deploy the workshop locally.

   Deploy the workshop locally using `make`.

   ```shell
   > make
   ```

1. Access the lab.

   Get the training portal URL and access the lab.

   ```shell
   > kubectl get trainingportal

   kubectl get trainingportal
   NAME             URL                                             PORTALPASSWORD   ADMINUSERNAME   ADMINPASSWORD            STATUS    MESSAGE
   spring-academy   http://spring-academy-ui.192.168.0.196.nip.io                    educates        GenderatedPasswordHere   Running
   ```

   Alternatively (after you've gotten your username and password),
   you can open the training portal dashboard directly:

   ```shell
   > make open-workshops
   URL=`kubectl get trainingportal/spring-academy -o go-template={{.status.educates.url}}`; (test -x /usr/bin/xdg-open && xdg-open $URL) || (test -x /usr/bin/open && open $URL) || true
   ```

   Note your URL might be different!

1. Run the workshop.
