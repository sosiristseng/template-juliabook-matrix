FROM python:3.12.5-slim

# System config
ENV JULIA_CI 'true'
ENV JULIA_NUM_THREADS 'auto'
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND 'Null'
ENV JULIA_DEPOT_PATH '/srv/juliapkg/'
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Python dependencies
COPY requirements.txt .
RUN uv pip install --system --no-cache jill nbconvert -r requirements.txt

# Julia dependencies
RUN jill install '1.11' --confirm --upstream Official && julia --version
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes -e 'using Pkg; Pkg.add("IJulia"); import IJulia; IJulia.installkernel("Julia", "--project=@.")' && \
    julia --color=yes --project=@. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
