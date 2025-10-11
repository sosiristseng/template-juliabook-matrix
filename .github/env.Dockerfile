FROM julia:1.12.0

# System config
ENV JULIA_CI='true'
ENV JULIA_NUM_THREADS='auto'
ENV JULIA_CONDAPKG_ENV=/app/.CondaPkg/envs/default

WORKDIR /app

# Julia dependencies
COPY Project.toml Manifest.toml build_docker.jl ./
COPY src/ src
RUN julia --color=yes build_docker.jl
