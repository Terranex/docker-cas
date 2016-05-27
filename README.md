# docker-cas
Dockerized implementation of [Apereo CAS](https://www.apereo.org/projects/cas) with authentication delegation via Facebook, Twitter and OpenID Connect enabled.

## Dependancies
##### This repository requires the following to run:
- [docker](https://docs.docker.com/linux/step_one/)

## Installation
The installation follows the following steps:

1. Pull the repository.
2. Run the `build.sh` script responsible for building your cas web app using Maven.
3. Customize the CAS config to suite your environment.
4. Run the `run.sh` script to start your CAS server.
5. Create your self-signed certificate in a custom keystore to enable HTTPS.

### 1. Pull the repository:
Choose a suitable directory and clone the repository:

`$ git clone https://github.com/Terranex/docker-cas.git`

### 2. Run the `build.sh` script.
Change directory to the cloned repo:

`$ cd docker-cas`

Run the build script:

`$ ./docker-cas/build.sh`

For any changes or additional packages you need to add to CAS, see the [CAS documentation](http://apereo.github.io/cas/4.2.x/index.html).

### 3. Customize the CAS config to suite your environment.
There are 3 files you can change for this specific setup:
  - `cas.properties` (CAS general configuration properties)
  - `pac4jContext.xml` ([Pac4J](http://www.pac4j.org/) context specific configuration, i.e. Java Bean setup.)
  - `server.xml` (Tomcat server configuration file.)
For this specific Auth-Delegation you may also choose to remove the `pac4jContext.xml` file and declare everything inside the cas.properties file, or alternatively comment out the `pac4j` properties in the `cas.properties` file and delclare everything inside the `pac4jContext.xml` file.

##### cas.properties
The first item you will want to change inside the `cas.properties` file is the `server.name` property which should match the hostname & port you've selected (default is port http://localhost:8000).

Next your Authentication delegation entries, i.e. the `cas.pac4j` entries for Facebook & Twitter. If you do not want to provide either of these authentication methods, just comment them out.
For both of these you will need to get an id & secret from Facebook & Twitter via their respective developer interfaces.

There are many other options you can enable and edit in this file. For more information see the [CAS documentation](http://apereo.github.io/cas/4.2.x/index.html)

### 4. Run the `run.sh` script to start your CAS server.

`$ ./docker-cas/run.sh`

You can also add the optional params for the HTTP & HTTPS ports(Default ports are 8000 and 8500 respectively.):

`$ ./docker-cas/run.sh 8080 8443`

This will start your CAS server container. To view the log run(`Ctrl+C` to exit):

`docker logs -f common-auth-cas`

You can expect to see some errors relating to the HTTPS connector, this is due to the fact that no keystore has been created yet. Alternatively you may comment out the HTTPS section in the Tomcat `server.xml` file located in the `runtime` directory if you are not planning on running this server on HTTPS.

### 5. Create your self-signed certificate & keystore.
Inside the runtime directory, there is a script `create_keystore` which is automatically mounted inside the container at startup. To run this script inside the container:

```
$ docker exec -it common-auth-cas sh
$ ./create_keystore

   What is your first and last name?
  [Unknown]:  {{Your fully qualified host name here}}
What is the name of your organizational unit?
  [Unknown]:  
What is the name of your organization?
  [Unknown]:  
What is the name of your City or Locality?
  [Unknown]:  
What is the name of your State or Province?
  [Unknown]:  
What is the two-letter country code for this unit?
  [Unknown]:  
Is CN=, OU=Unknown, O=Unknown, L=Unknown, ST=, C= correct?
  [no]:  yes

Enter key password for <cas>
	(RETURN if same as keystore password):
	
$ exit
```
Your keystore with a self-signed certificate is nou created and your Tomcat restarted.

Navigate to [https://localhost:8500/cas](https://localhost:8500/cas).
