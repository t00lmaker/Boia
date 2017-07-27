#!/bin/bash 

echo "-----> Iniciando o restart do container boia"

echo "----> 1. Parando o container"
docker stop boia-app
echo "----> 2. Removendo o container"
docker rm boia-app
echo "----> 3. Criando outro container boia"
docker  run -d  --name boia-app --hostname boia -v /root/Boia:/app -p 8081:3000  boia-image:v4

echo "-----> Finalizado o restart do container boia"
echo ""
echo "-----> Acessar o container: docker exec -it boia-app bash"
