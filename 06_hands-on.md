# Hands-on n.2

![](resources/images/hands-on-2.png)

Notes :
- On utilise toujours https://github.com/vdemeester/flask-by-example
- Dans le premier exercie on deploie flask-by-example (application multi-container) sur un host distant (uniquement un). Le host distant peut-être aussi un VM virtualbox en local. Utiliser docker-machine. 
- Dans le deuxièem exerice on deploie les 3 containers de flask-by-example sur 3 Docker Hosts differents.



## Mission n.1 ~ niveau Ninja

<img src="resources/images/ninja.jpeg" style="right:0;position:fixed;">

*En utilisant docker machine* :

* Créer un nouveau Docker host 
* Déployer flask-by-example sur ce host

*Hints* :

* Utiliser la commande docker-machine create
* Penser à activer le flux TCP sur le port 80 si ce n'est pas le cas
* Configurer les variables d'environnments : $(docker-machine env)
* Utiliser docker-compose pour deployer flask-by-example



## Mission n.2 ~ niveau Jedi

<img src="resources/images/jedi.jpeg">
<br>
En utilisant docker :

* Arreter les containers frontend et backend (pas les autres)
* Déployer frontend et backend sur un autre host en faisant les liens à la main


