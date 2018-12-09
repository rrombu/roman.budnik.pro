FROM ruby:alpine

ARG bulma_version

RUN apk add --no-cache make gcc libc-dev && \
    gem install sass && \
    wget https://github.com/jgthms/bulma/releases/download/$bulma_version/bulma-$bulma_version.zip && \
    unzip bulma-$bulma_version.zip && \
    mv bulma-$bulma_version bulma

COPY ./html/styles/bulma.scss .

RUN sass --sourcemap=none bulma.scss bulma.css

FROM pierrezemb/gostatic:latest

COPY html /srv/http/
COPY --from=0 /bulma.css /srv/http/styles/
