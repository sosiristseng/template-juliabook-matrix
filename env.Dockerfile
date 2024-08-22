FROM julia:1.10.4 as julia
FROM ghcr.io/astral-sh/uv:latest as uv
FROM python:3.12.5-slim

# System config
ENV UV_SYSTEM_PYTHON '1'
ENV JULIA_CI 'true'
ENV JULIA_NUM_THREADS 'auto'
ENV JULIA_CPU_TARGET 'generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1);znver3,clone_all'
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND 'Null'
ENV JULIA_PATH '/usr/local/julia/'
ENV JULIA_DEPOT_PATH '/srv/juliapkg/'
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia ${JULIA_PATH} ${JULIA_PATH}
COPY --from=uv /uv /bin/uv

WORKDIR /app

# Python dependencies
COPY requirements.txt .
RUN uv pip install --no-cache -r requirements.txt

# Julia dependencies
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes -e 'using Pkg; Pkg.add(["IJulia", "Literate", "JSON"]); import IJulia; IJulia.installkernel("Julia", "--project=@.")' && \
    julia --color=yes --project=@. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
