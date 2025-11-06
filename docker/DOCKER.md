### POC over docker-compose locally
To work around this, I added entries for keycloak and oauth2 in the **/etc/hosts** file to achieve faster local testing and access.  
Therefore, before running docker-compose, you need to update **/etc/hosts** and add the following entry: 
```
127.0.0.1       keycloak
127.0.0.1       test.example.local
```  
A possible **improvement** for the local environment would be to implement routing through an Nginx container or use a solution such as [Ngrok](https://ngrok.com/).  

Used images:
* postgres:17.6-alpine3.22
* keycloak/keycloak:26.4
* nginx:1.25-alpine
* quay.io/oauth2-proxy/oauth2-proxy:v7.6.0
