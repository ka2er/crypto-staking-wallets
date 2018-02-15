# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.10.0

CMD ["/sbin/my_init"]

# upgrade OS
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# crypto dev-tools
### try install_clean
#RUN apt-get install  --no-install-recommends -y nano git automake build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev software-properties-common libdb4.8-dev libdb4.8++-dev libminiupnpc-dev
RUN install_clean  --no-install-recommends -y nano git automake build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev software-properties-common libdb4.8-dev libdb4.8++-dev libminiupnpc-dev bsdmainutils
# ...put your own build instructions here...
#RUN apt-get install -y bsdmainutils§

ENV PROJECT          alqo
ENV GIT_URL          git://github.com/ALQOCRYPTO/ALQO.git
ENV HOME_DIR         /usr/local/bin


RUN mkdir -p /opt/code/ && cd /opt/code/ && git clone ${GIT_URL} ${PROJECT} && cd /opt/code/${PROJECT} && ./autogen.sh \
	&& ./configure --enable-tests=no --with-incompatible-bdb --enable-glibc-back-compat --with-gui=no \
#CFLAGS="-march=native" LIBS="-lcurl -lssl -lcrypto -lz" \
	&& make -j4 && make install && rm -rf /opt/code/


## Adding wallet daemon
RUN mkdir /etc/service/$PROJECT
COPY run.sh /etc/service/$PROJECT/run
RUN chmod +x /etc/service/$PROJECT/run

## add a non priviligied user (cf run.sh)
RUN groupadd -r wallet && useradd --no-log-init -r -g wallet wallet

VOLUME /home/wallet

# cleanup building tools
#RUN apt-get purge -y nano git automake build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev software-properties-common libdb4.8-dev libdb4.8++-dev libminiupnpc-dev bsdmainutils
# Clean up APT when done.
RUN apt-get autoremove -y && apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 


## Running scripts during container startup
#RUN mkdir -p /etc/my_init.d
#COPY logtime.sh /etc/my_init.d/logtime.sh
#RUN ln -sf /usr/local/bin/alqod /etc/my_init.d/
#RUN chmod +x /etc/my_init.d/logtime.sh



