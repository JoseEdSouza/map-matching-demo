# Links de referência para a imagem Docker utilizada
# https://github.com/IsraelHikingMap/graphhopper-docker-image-push/blob/main/Dockerfile
# https://github.com/IsraelHikingMap/graphhopper-docker-image-push

# Exemplo de configuração via docker-compose (comentado para referência)
#   import-map:
#     image: israelhikingmap/graphhopper:latest
#     container_name: import_osm
#     environment:
#       - JAVA_OPTS=-Xmx8g -Xms8g
#       - FILE=/data/newson_krumm_reconstructed_2.osm.pbf
#       - ACTION=import
#       - CONFIG=/config/config.yaml
#     volumes:
#       - ./tools/graphhopper/volumes/graphhopper_data:/data
#       - ./osm/pbf:/osm
#       - ./tools/graphhopper/config:/config
#     entrypoint:  ["./graphhopper.sh", "-c", "/config/config.yaml"]

# Definição de variáveis locais: pasta de redes e nome do arquivo OSM
ROAD_NETWORK_DIR=networks
FILENAME=ohare_network.osm.xml

# Limpeza prévia: remove dados antigos do GraphHopper para garantir uma importação limpa
rm -rf ./graphhopper/volumes/graphhopper_data/*

# Execução do container Docker para IMPORTAÇÃO da malha
# --rm: remove o container automaticamente após terminar (pois é um processo one-off)
docker run --rm \
    -e JAVA_OPTS="-Xmx8g -Xms8g" \
    -e FILE="/road-network/$FILENAME" \
    -e ACTION="import" \
    -e CONFIG="/config/config.yaml" \
    -v "$(pwd)/$ROAD_NETWORK_DIR:/road-network" \
    -v "$(pwd)/graphhopper/config:/config" \
    -v "$(pwd)/graphhopper/volumes/graphhopper_data:/data" \
    --entrypoint ./graphhopper.sh \
    israelhikingmap/graphhopper:latest \
    -c /config/config.yaml
