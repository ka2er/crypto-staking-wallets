# To open a bash session inside the container, you must pass -t -i so that a terminal is available:

docker exec -t -i YOUR-CONTAINER-ID bash -l

docker run --rm -t -i phusion/baseimage:<VERSION> /sbin/my_init -- bash -l

docker run --rm -t -i ka2er/crypto-wallet-alqo bash -l


