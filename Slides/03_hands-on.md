# Hands-on n.1

![](resources/images/hands-on-1.png)

Notes :
- Using https://github.com/vdemeester/flask-by-example
- Plusieurs façon d'utiliser fig : installer via pip, package manager
  ou utiliser image dduportal/fig
- Une app qui a besoin de (SGBD [write], Elasticsearch [read/index],
  MQ [events], .. )
- TODO1 : mise en place ave fig/compose des env' pour le faire tourner
- TODO2 : coder une mini feature ? (bonus ?)



## Votre mission..

.. Si vous l'acceptez !

Faire tourner *flask by example* grâce à docker-compose.

![](resources/images/flask-redis-postgres.png)



## À votre disposition

- Les différentes sources se trouve ici : http://github.com/zenika/..
    - ``frontend`` & ``backend`` : source de notre application
    - ``docker-compose.yml`` : fichier à compléter
- Images sur lesquelles se baser
    - postgres (officielle)
    - redis (officielle)
    - backend (basé sur python)
    - frontend (basé sur python, même container que backend ^_^'')



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



## Solution ?

![](resources/images/wondering.gif)

<!-- beurk -->
<center>Pizza time <code>\o/</code></center>
