FROM debian:bullseye
MAINTAINER leifj@sunet.se
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get -q update
RUN apt-get -y dist-upgrade
RUN apt-get -y install apache2 gitweb
RUN a2enmod rewrite
RUN mkdir -p /var/www
COPY /start.sh /
RUN chmod a+rx /start.sh
COPY /apache2.conf /etc/apache2/
EXPOSE 80
EXPOSE 443
VOLUME /etc/ssl
ENV ACMEPROXY "acme-c.sunet.se"
ENTRYPOINT ["/start.sh"]
