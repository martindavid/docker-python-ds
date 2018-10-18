FROM python:3.6.6-alpine3.8
LABEL maintainer="Martin Valentino <mvalentino@martinlabs.me>"

RUN apk add --update bash
RUN apk add --no-cache build-base libffi-dev

ENV INSTALL_ROOT /install
RUN mkdir -p $INSTALL_ROOT

WORKDIR $INSTALL_ROOT

COPY Pipfile* $INSTALL_ROOT/

RUN pip install pipenv \
    && pipenv install --system --deploy \
    && pip uninstall -y pipenv \
    && find /usr/local/lib/ \
        \( -type d -a -name test -o -name tests  -o -name __pycache__ \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' +