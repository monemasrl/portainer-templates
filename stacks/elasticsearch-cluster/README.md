## Generazione certificati

docker compose -f build.yml up

## Build delle immagini

docker compose build
docker compose push


#docker service create --name registry --publish 5000:5000 registry:2
