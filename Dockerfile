# Get the image that we want to use.
# Debian is small yet simple so we use that

FROM debian

# !!!! DON'T RUN THIS FILE BEFORE YOU'VE DONE THIS !!!!
#   Run `make docker` to properly prepare the Docker environment

COPY .tmp/libcsv/ /libcsv

RUN apt-get update && apt-get install gcc make nano vim -y

# TODO: run `docker run -it <name_of_built_container>:<xxxxxxx> /bin/bash` to run your dock
