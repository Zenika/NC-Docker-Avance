# Cycle de vie (bis)

![](resources/images/pret-pas-pret.jpg)



## Rappels

![](resources/images/decouverte-conteneur-workflow.png)

Notes :
<!--- ![](resources/images/decouverte-conteneur-workflow.png) -->
<!-- ![](resources/images/lifecycle.png) -->



## Images : quelques commandes en plus

- ``history`` : voir l'historique d'une image
- Option ``--tree`` : voir l'arbre des layers de chaque image
<br/><br/>
- ``save`` : sauvegarder dans une archive une images (avec ses layers)
- ``load`` : recharger une images (avec ses layers) à partir d'un tar

Notes :
- load, save -> à ne pas confondre avec export/load (sur conteneurs)
- docker history golang, docker images --tree
- docker save --output golang.tar golang, docker rmi golang golang:1.3, docker load --input golang.tar
- regarder filter



## Publier vos images

1. ``tag`` : étiquetter une image dans un repository
```bash
$ docker tag monimage monimage:1
$ docker tag monimage privateregistry.com/vdemeester/monimage:latest
```
2. ``push`` : envoyer une image sur le repository (public ou privé)
```bash
$ docker push monimage
$ docker push privateregistry.com/vdemeester/monimage:latest
```
3. ``pull`` : récupérer une image depuis le repository
```bash
$ docker pull monimage
$ docker pull privateregistry.com/vdemeester/monimage:latest
```

Notes :
- pull/push, automated build.. <= publier vos images
- Local registry
- docker tag golang golang:mine && docker images | grep golang



## Dockerfile

- ``ENTRYPOINT`` : Définir un point d'entrée (*Wat?*)
  Override tout élément ``CMD`` ; permet de passer dans argument à un
  conteneur qui seront traités par le *entrypoint*

- ``ONBUILD`` : instruction qui sera exécuter quand une image sera
  construite à partir de la courante. Limité à ``RUN`` et ``ADD`` pour l'instant.
```bash
ONBUILD RUN /usr/local/bin/cabal install --only-dependencies
```

<br />

- Attention à l'ordre des commandes (``WORKDIR``, ``VOLUME``, ..)


<br/><br/>


Notes :
- ENTRYPOINT : démo avec un echo :)
- ONBUILD : démo avec un build ? (Dockerfile abstrait)
- ADD : si tar.{gz,..} -> extrait automatiquement
- Rappels sur le comportement de certaines commande WORKDIR



## Conteneurs (1/2)

- ``export`` : exporter le contenu d'un conteneur (tar).
  - Ne contient pas les volumes
  - Ne contient pas les layers (de l'image sous-jacente)
- ``import`` : créer une image à partir d'une archive (tar)
  - Créer une image vide, donc pas de layer
  - Prends une URL (http) ou ``-`` et entrée standard
- ``inspect`` : Récupérer des informations *bas-niveau* sur un
  conteneur
    - Par défault JSON, mais possible de lui passer des *format*

Notes :
- ``export`` souvent utilisé pour *applatir* une image
- ``inspect`` démo avec formats : 
    - docker inspect --format '{{.NetworkSettings.IPAddress}}' id
    - docker inspect id | grep IPAddress | cut -d '"' -f 4



## Conteneurs (2/2)

- ``exec`` : exécuter une commande dans un conteneur
- ``port`` : Lister les ports mappés (bindés) pour un conteneur
- ``top`` : afficher les processus du conteneur
- ``stats`` : afficher des statistiques pour un conteneur
- ``logs`` : Récupérer les logs d'un conteneur (stout, stderr), avec
ou sans timestamp, en mode follow (tail -f) ou non.

- ``wait`` : attendre qu'un container se termine

Notes :
- export/import
- docker events, docker stats id, docker top id, docker logs id
- kill, wait, exec <-- make it work (enter)
- cp : copies a folder out of a container fs


