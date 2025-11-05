# Inventory 

Holds all server information necesarry for sucessfull execution of ansible-playbooks.

# List

- [hosts.yaml](./hosts.yaml)
    - Contains all servers on which can be executed this playbook.
- [local.yaml](./local.yaml)
    - Contains bare minimal information for running playbook localy or on servers which require to be executed directly on server.  
    - ```NOTE: You need to transfer this project on server, make sure you have access to Git Repo and HTTPS connection from server on which you are executing.```  
