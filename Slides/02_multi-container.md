# Multi conteneurs

<img style="float: left; position: fixed; bottom: 0; z-index: -100;" src="resources/images/42fois.jpg" />



## Pourquoi ?

- Un conteneur, un processus
- Un application c'est bien souvent plusieurs processus

- Example : [Flask by Example](https://realpython.com/blog/python/flask-by-example-part-1-project-setup/)
    - PostgreSQL
    - Redis
    - Backend
    - Frontend

Notes :
- Besoin réel, plusieurs conteneurs, ...
- TODO: schema (inspiration gitlab schema :
https://github.com/gitlabhq/gitlabhq/blob/master/doc/development/gitlab_diagram_overview.png)



## Comment ?

**TODO** Schema

Docker fournit un mécanisme : les liens (``links``)

Notes :
- Schema avec les différents composants dans des docker (mode dev,
  mode prod)



## Links (1/2)

Lier des conteneurs sans *binder* leurs ports<br/><br/>

Syntaxe : ``--link <name or id>:<alias>``


```bash
$ docker run -d --name mymysql mysql
$ docker run -d -P --name web --link mymysql:db myapp
```

- Défini des vabriable d'environnement dans la destination (``web``)
- L'alias va servir de prefix pour ces variables
- Pas de magie, votre application doit prendre en compte ces variables

Notes :
- Port ne sont pas binder/exposés
- Le conteneur ``db`` n'est pas bindé sur le host



## Links (2/2)

- Variables d'environnement
    - ``DB_NAME`` ➜ /web/db
    - ``DB_PORT`` ➜ tcp://172.17.0.5:5432
    - ``DB_PORT_5432_TCP`` ➜ tcp://172.17.0.5.5432
    - ``DB_PORT_5432_TCP_PROTO`` ➜ tcp
    - ``DB_PORT_5432_TCP_PORT`` ➜ 5432
    - ``DB_PORT_5432_TCP_ADDR`` ➜ 172.17.0.5

Notes :
- Demo avec un conteneur qui ``EXPOSE`` plusieurs port et un link



## Let's do it (manually)

- Redis : ``docker run -d --name redis redis``
- PostgreSQL : ``docker run -d --name postgres postgresql``
- Backend : ``docker run -d --link redis:redis --link postgres:db --name backend mybackend``
- Frontend :``docker run -d --link redis:redis --link postgres:db --name backend myfrontend``
![](resources/images/giphy_whatif1.gif)

Et si on pouvait faire ça en une commande ?

Notes :
- exemple + interactif sur mise en place à la main
- L'ordre est important, 4 commandes c'est pas la mort mais..



## Outils

- *Docker-compose* a.k.a **fig** (python, conf. yaml)
    - Support officiel Docker

- Crane (Go, conf. json/yaml)
- Maestro (Python, conf. yaml)
- Decking (Node, conf. json)

- cloud ready : kubernetes, ...

Notes :
- à la main c'est bien mais.. je suis fainéant.. :D
- Local (now) / distant (2nd partie @mariolet)
- fig, decking, flocker, ...



## docker-compose : configuration

docker-compose.yml
```
web:
    build: .
    command: python app.py
    links:
    - db
    ports:
    - "8000:8000"
mycontainer:
    build: ./path
    expose:
    - "3000"
    volumes:
    - ~/configs:/etc/configs/:ro
    net: "none"
    user: moi
db:
    image: postgres
    environment:
    - LANG=C
```

Notes :
- introduction, feature, démo



## docker-compose (2/2) : commandes

- ``up`` : démarrer tous ou un les conteneurs
- ``build`` : construire les images & conteneurs sans les démarrer
- ``start``, ``stop``, ``kill`` : démarrer, arrêter, tuer
- ``run`` : démarrer un conteneur avec un autre commande
- ``logs``, ``port``, ``ps`` : voir les infos (logs, port, processus)
- ``scale`` : définir le nombre de containers à lancer pour chaque
```bash
$ fig scale web=2 worker=3
```

Notes :
- live demo avec scale également



## Let's (re)do it

![](resources/images/loi-murphy.jpg)

