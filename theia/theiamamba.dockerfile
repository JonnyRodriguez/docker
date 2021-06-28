ARG NODE_VERSION=12.18.3

FROM node:${NODE_VERSION}-buster
WORKDIR /home/theia
ADD package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

FROM node:${NODE_VERSION}-buster-slim

EXPOSE 3000
WORKDIR /home/theia
ENV HOME=/home/theia \
    PATH="/home/theia/mambaforge/bin:$PATH" \
    SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins \
    USE_LOCAL_GIT=true

RUN apt update \
    && apt upgrade -y \
    && apt install -y curl git sudo \
    && curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh -o /tmp/mambainstall.sh \
    && bash /tmp/mambainstall.sh -b \
    && mamba install -y python-language-server flake8 autopep8 \
    && apt clean \
    && apt auto-remove -y \
    && rm -rf /var/cache/apt/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

COPY --from=0 /home/theia /home/theia
COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh"]
CMD [ "node", "/home/theia/src-gen/backend/main.js", "/home/project", "--hostname=0.0.0.0" ]
