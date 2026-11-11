# gerbert3005

## ruby

For my other classes, i've been using lots of python and c++. I wanted to switch it up and try the best language in the world, ruby

ActiveRecord is the most popular ruby ORM. It's a part of the larger Ruby on Rails framework, but this project just uses ActiveRecord alone. 

## container stuff

https://docs.docker.com/compose/gettingstarted

I've decided to use this project as an opportunity to learn more about docker.

The ruby app and the two services postgres and pgadmin are run through docker compose. Run `docker compose up` or `docker compose down` to start/stop the guy

This project also uses a vscode dev container, which requires the dev containers addon; vscode will start a container and ssh into it. What's nice about working in a container is that I can use the exact same ruby as the "production" app, and I don't have to install ruby on my computer. Ruby is very frustrating to install, and it's equally annoying to manage ruby versions, so this is quite a lifesaver. 

Unforutnately, my dev container and production container configs have some code duplication... I spent some time looking into ways of sharing a dockerfile between the devcontainer and compose.yaml but it was taking too long

