# Docker Role
Playbook role for installation of [Docker CE](https://www.docker.com/) with customized [Docker Daemon](https://docs.docker.com/config/daemon/) Confiuration.

- [handlers](./handlers/main.yml)
    - Holds steps for restart of docker socket and service, in order to change [daemon](./templates/daemon.json.j2) configuration. 
- [tasks](./tasks/main.yml)
    - Holds steps for installation of [Docker CE](https://www.docker.com/) Engine with default configuration.      
- [templates](./templates/daemon.json.j2)
    - Holds custom [Docker Daemon](https://docs.docker.com/config/daemon/) configuration.  
- [vars](./vars/docker.yml)
    - Holds variables used by [tasks](./tasks/main.yml) script.
