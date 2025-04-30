# pull the official base image
FROM python:3.10-slim-buster

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN set -ex; \
    apt-get update -y && \
    apt-get install -y --no-install-recommends jq;
RUN pip3 install --upgrade pip

RUN pip3 install tccli

# check if installation success 
RUN tccli --version