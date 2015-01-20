# docker-phpmoadmin

A [Docker](https://docker.com/) container for [phpMoAdmin](http://www.phpmoadmin.com/).

## Run the container

Using the `docker` command:

    CONTAINER="phpmoadmindata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmoadmin/ssl/certs \
      -v /phpmoadmin/ssl/private \
      simpledrupalcloud/data:latest

    CONTAINER="phpmoadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmoadmindata \
      -e SERVER_NAME="localhost" \
      -d \
      simpledrupalcloud/phpmoadmin:latest

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmoadmin.git "${TMP}" \
      && cd "${TMP}" \
      && sudo fig up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmoadmin.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t simpledrupalcloud/phpmoadmin:latest . \
      && cd -

## Back up phpMoAdmin data

    sudo docker run \
      --rm \
      --volumes-from phpmoadmindata \
      -v $(pwd):/backup \
      simpledrupalcloud/base:latest tar czvf /backup/phpmoadmindata.tar.gz /phpmoadmin/ssl/certs /phpmoadmin/ssl/private

## Restore phpMoAdmin data from a backup

    sudo docker run \
      --rm \
      --volumes-from phpmoadmindata \
      -v $(pwd):/backup \
      simpledrupalcloud/base:latest tar xzvf /backup/phpmoadmindata.tar.gz

## License

**MIT**
