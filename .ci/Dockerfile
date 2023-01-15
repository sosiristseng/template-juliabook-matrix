FROM jupyter/base-notebook:python-3.10.8

WORKDIR ${HOME}
USER root

# Environment variables
ENV APP_BASE /srv
ENV JULIA_PATH ${APP_BASE}/julia
ENV JULIA_DEPOT_PATH ${JULIA_PATH}/pkg
ENV JULIA_NUM_THREADS "auto"
ENV PATH ${JULIA_PATH}/bin:${PATH}

RUN mkdir -p ${JULIA_DEPOT_PATH} && \
chown 1000 ${JULIA_DEPOT_PATH}

# System packages
# RUN apt-get update && \
#     apt-get upgrade -y && \
#     apt-get install -y --no-install-recommends \
#     locales less unzip && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# Julia binary
COPY --from=julia:1.8.5 /usr/local/julia ${JULIA_PATH}

# Python deps
COPY --chown=1000:100 requirements.txt ${HOME}
RUN pip install --no-cache-dir -r requirements.txt

# Julia environment
USER jovyan
COPY --chown=1000:100 Project.toml Manifest.toml ${HOME}
COPY --chown=1000:100 src/ src
RUN julia --project="" -e "import Pkg; Pkg.add(\"IJulia\"); using IJulia; installkernel(\"Julia\", \"--project=${HOME}\");" && \
    julia --project=@. -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'

# Make the Julia kernel available for both user and root
USER root
RUN julia --project="" -e "import Pkg; using IJulia; installkernel(\"Julia\", \"--project={HOME}\");"

# We always want containers to run as non-root
USER jovyan
