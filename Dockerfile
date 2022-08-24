FROM docker.io/python:alpine as localization

RUN pip install Jinja2
COPY mainpage /
RUN python main.py

FROM docker.io/ruby:alpine as sass

ARG bulma_version

RUN apk add --no-cache make gcc libc-dev && \
    gem install sass && \
    wget https://github.com/jgthms/bulma/releases/download/$bulma_version/bulma-$bulma_version.zip && \
    unzip bulma-$bulma_version.zip

COPY ./html/styles/bulma.scss .

RUN sass --sourcemap=none bulma.scss bulma.css

FROM docker.io/pierrezemb/gostatic:latest

COPY html /srv/http/
COPY --from=localization /results /srv/http/
COPY --from=sass /bulma.css /srv/http/styles/
