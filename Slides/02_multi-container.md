# Multi conteneurs

![](resources/images/pret-pas-pret.jpg)



## Pourquoi ?

- 1 conteneurs, 1 processus
- Mon application, plusieurs services<br/>
    - Redis
    - PostgreSQL
    - Elasticsearch
    - Tomcat

Notes :
- Besoin réel, plusieurs conteneurs, ...
- TODO: schema (inspiration gitlab schema :
https://github.com/gitlabhq/gitlabhq/blob/master/doc/development/gitlab_diagram_overview.png)



## Comment ?

Notes :
- Schema avec les différents composants dans des docker (mode dev,
  mode prod)



## Links (1/2)

Lier des conteneurs sans *binder* leurs ports<br/><br/>

Syntaxe : ``--link <name or id>:<alias>``


```bash
$ docker run -d --name db mysql
$ docker run -d -P --name web --link db:db myapp
```

- Défini des vabriable d'environnement dans la destination (``web``)
- L'alias va servir de prefix pour ces variables
- Pas de magie, votre application doit lire ces variables

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


Notes :
- exemple + interactif sur mise en place à la main



## Outils


Notes :
- à la main c'est bien mais.. je suis fainéant.. :D
- Local (now) / distant (2nd partie @mariolet)
- fig, decking, flocker, ...



## Docker compose (fig)

Notes :
- pourquoi présenter celui là ? << officiel
- introduction, feature, démo

