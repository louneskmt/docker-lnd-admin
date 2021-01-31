ARG VERSION=v0.10.12

FROM node:12-buster-slim AS builder

ARG VERSION

WORKDIR /build

RUN apt-get update

RUN apt-get install -y git python3 build-essential

RUN git clone --branch $VERSION https://github.com/janoside/lnd-admin .

RUN npm install

RUN rm -rf .git

FROM node:12-buster-slim

USER 1000

WORKDIR /data

COPY --from=builder /build .

CMD [ "npm", "start" ]