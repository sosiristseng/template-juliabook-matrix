FROM julia:1.11.1

# System config
ENV JULIA_CI='true'
ENV JULIA_NUM_THREADS='auto'
ENV JULIA_CONDAPKG_ENV="/app/.env"

WORKDIR /app

# Julia dependencies
COPY Project.toml Manifest.toml instantiate.jl ./
COPY src/ src
RUN julia --color=yes instantiate.jl
