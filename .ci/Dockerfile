FROM python:3.11.1-slim

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Use bash as default shell, rather than sh
ENV SHELL /bin/bash

# Set up user
ARG NB_USER=jojo
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN groupadd \
        --gid ${NB_UID} \
        ${NB_USER} && \
    useradd \
        --comment "Default user" \
        --create-home \
        --gid ${NB_UID} \
        --no-log-init \
        --shell /bin/bash \
        --uid ${NB_UID} \
        ${NB_USER}

# Allow target path repo is cloned to be configurable
WORKDIR ${HOME}
RUN chown ${NB_USER}:${NB_USER} ${HOME}

# Environment variables required for build
ENV APP_BASE /srv
ENV JULIA_PATH ${APP_BASE}/julia
ENV JULIA_DEPOT_PATH ${JULIA_PATH}/pkg
ENV JULIA_NUM_THREADS "auto"
ENV PATH ${JULIA_PATH}/bin:${PATH}

RUN mkdir -p ${JULIA_DEPOT_PATH} && \
chown ${NB_USER}:${NB_USER} ${JULIA_DEPOT_PATH}

# Set up locales properly
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Set up locales properly
RUN apt-get update -qq && \
    apt-get upgrade -qqy && \
    apt-get install -qqy --no-install-recommends \
    locales less unzip && \
    apt-get -qq purge && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Julia binary
COPY --from=julia:1.8.5 /usr/local/julia ${JULIA_PATH}

# Python deps
COPY --chown=${NB_UID}:${NB_UID} requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Julia environment
USER ${NB_USER}
COPY --chown=${NB_UID}:${NB_UID} Project.toml Manifest.toml ${HOME}
COPY --chown=${NB_UID}:${NB_UID} src/ src
RUN julia --project="" -e "import Pkg; Pkg.add(\"IJulia\"); using IJulia; installkernel(\"Julia\", \"--project=${HOME}\");" && \
    julia --project=@. -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'

# Make the Julia kernel available for both user and root
USER root
RUN julia --project="" -e "import Pkg; using IJulia; installkernel(\"Julia\", \"--project=${HOME}\");"

# We always want containers to run as non-root
USER ${NB_USER}

EXPOSE 8888

ENTRYPOINT [ ]

# Specify the default command to run
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
