FROM node:lts-buster
LABEL author="Guillaume AUGAIS"

RUN apt update
RUN apt install -y openjdk-11-jre libgbm-dev pandoc

ENV SCALA_VERSION 2.13
ENV AMM_VERSION 2.5.11
ENV MILL_VERSION 0.11.7

ENV AMM_FILE $SCALA_VERSION-$AMM_VERSION
ENV AMM_URL https://github.com/lihaoyi/Ammonite/releases/download/$AMM_VERSION/$AMM_FILE

# RUN sh -c '(echo "#!/usr/bin/env sh" && curl -L https://github.com/com-lihaoyi/Ammonite/releases/download/$AMM_VERSION/$SCALA_VERSION-$AMM_VERSION) > /usr/local/bin/amm && chmod +x /usr/local/bin/amm'
RUN (echo '#!/usr/bin/env sh' && curl -LSsf -- "$AMM_URL") > /usr/local/bin/amm \
 && chmod +x "/usr/local/bin/amm" \
 && mkdir -p ~/.ammonite
 

RUN amm -c ""

RUN \
  curl -L -o /usr/local/bin/mill https://github.com/lihaoyi/mill/releases/download/$MILL_VERSION/$MILL_VERSION && \
  chmod +x /usr/local/bin/mill && \
  touch build.sc && \
  mill -i resolve _ && \
  rm build.sc

WORKDIR "/app"

RUN cd "/app"
RUN npm install -g pagedjs-cli@0.1.6 --unsafe-perm=true --allow-root

COPY ["entrypoint", "/entrypoint"]
ENTRYPOINT ["/entrypoint"]

CMD ["bash"]