# docker-phpmoadmin

A [Docker](https://docker.com/) container for [phpMoAdmin](http://www.phpmoadmin.com/).

## Run the container

Using the `docker` command:

    CONTAINER="phpmoadmindata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /phpmoadmin \
      simpledrupalcloud/data:dev

    CONTAINER="phpmoadmin" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from phpmoadmindata \
      -e SERVER_NAME="localhost" \
      -d \
      simpledrupalcloud/phpmoadmin:dev

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmoadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo fig up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-phpmoadmin.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo docker build -t simpledrupalcloud/phpmoadmin:dev . \
      && cd -

## Back up phpMoAdmin data

    sudo docker run \
      --rm \
      --volumes-from phpmoadmindata \
      -v $(pwd):/backup \
      simpledrupalcloud/base:dev tar czvf /backup/phpmoadmindata.tar.gz /phpmoadmin

## Restore phpMoAdmin data from a backup

    sudo docker run \
      --rm \
      --volumes-from phpmoadmindata \
      -v $(pwd):/backup \
      simpledrupalcloud/base:dev tar xzvf /backup/phpmoadmindata.tar.gz

## License

**MIT**
