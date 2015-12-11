FROM nginx

RUN apt-get update && apt-get install -y git

RUN mkdir -p /letsencrypt/challenges/.well-known/acme-challenge
RUN git clone https://github.com/letsencrypt/letsencrypt /letsencrypt/app
WORKDIR /letsencrypt/app
RUN ./letsencrypt-auto; exit 0

# You should see "OK" if you go to http://<domain>/.well-known/acme-challenge/health

RUN echo "OK" > /letsencrypt/challenges/.well-known/acme-challenge/health


RUN rm /etc/nginx/conf.d/*.conf
ADD nginx/nginx.conf /etc/nginx/
ADD nginx/letsencrypt.conf /etc/nginx/conf.d/
ADD update_certs.sh /letsencrypt/

ADD nginx/letsencrypt.conf /etc/nginx/snippets/letsencrypt.conf

WORKDIR /letsencrypt
CMD ["nginx", "-g", "daemon off;"]
