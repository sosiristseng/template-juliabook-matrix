FROM julia:1.11.1 AS julia
FROM python:3.13.0-slim

# System config
ENV JULIA_CI='true'
ENV JULIA_NUM_THREADS='auto'
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND='Null'
ENV JULIA_PATH='/usr/local/julia/'
ENV PATH=${JULIA_PATH}/bin:${PATH}
COPY --from=julia ${JULIA_PATH} ${JULIA_PATH}
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Python dependencies
COPY requirements.txt .
RUN uv pip install --system --no-cache nbconvert -r requirements.txt

# Julia dependencies
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes -e 'using Pkg; Pkg.add("IJulia"); import IJulia; IJulia.installkernel("Julia", "--project=@.")' && \
    julia --color=yes --project=@. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
