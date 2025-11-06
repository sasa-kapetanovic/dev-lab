### Overview
This Ansible setup automates a complete environment for a containerized web stack:

- Installs Linux prerequisites and Docker.
- Runs application containers via docker-compose, including Keycloak, OAuth2 Proxy, PostgreSQL, and the web application.
- Configures Nginx servers:
  - A host-level Nginx instance acting as a reverse proxy that routes requests to OAuth2 Proxy, Keycloak, and the web container.
  - The configuration defines multiple location blocks for handling authentication, static assets, and realm endpoints.
  - A containerized Nginx instance serves the static website content.

The design is idempotent you can safely re-run the playbooks without causing unintended changes.

### Repository Structure

```
├── ansible.cfg
├── ANSIBLE_DOCS.md
├── group_vars
├── inventory
│   ├── hosts.yaml
│   └── README.md
├── log
│   └── output.log
├── roles
│   ├── compose
│   │   ├── files
│   │   ├── tasks
│   │   ├── templates
│   │   └── vars
│   ├── docker
│   │   ├── install
│   │   └── README.md
│   ├── nginx
│   │   ├── tasks
│   │   ├── templates
│   │   └── vars
│   ├── README.md
│   ├── requirements
│   │   ├── tasks
│   │   └── templates
│   └── web
│       ├── favicon.ico
│       ├── index.html
│       ├── protected_image.png
│       └── style.css
└── setup-full.yaml
```