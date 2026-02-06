FROM julia:1.12.4 AS julia
FROM python:3.14.2-slim AS base

# System config
ENV OPENBLAS_NUM_THREADS=1
ENV JULIA_CI='true'
ENV JULIA_NUM_THREADS='auto'
# GitHub runner CPU arch
ENV JULIA_CPU_TARGET='generic;icelake-server,clone_all;znver3,clone_all'
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND='Null'
ENV JULIA_PATH /usr/local/julia/
ENV JULIA_DEPOT_PATH /srv/juliapkg/
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia ${JULIA_PATH} ${JULIA_PATH}

WORKDIR /app

# Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Julia dependencies
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes -e 'using Pkg; Pkg.add(["Literate", "JSON"]); Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.precompile()'
