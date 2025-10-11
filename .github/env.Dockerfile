FROM julia:1.12.0

# System config
ENV JULIA_CI='true'
ENV JULIA_NUM_THREADS='auto'

WORKDIR /app

# Julia dependencies
COPY Project.toml Manifest.toml build_docker.jl ./
COPY src/ src
RUN julia --color=yes build_docker.jl
