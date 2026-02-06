FROM julia:1.12.4

# System config
ENV JULIA_CI='true'
ENV JULIA_NUM_THREADS='auto'
ENV JULIA_CPU_TARGET='generic;icelake-server,clone_all;znver3,clone_all'
ENV OPENBLAS_NUM_THREADS=1

WORKDIR /app

# Julia dependencies
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes -e 'using Pkg; Pkg.add(["Literate", "JSON"]); Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.precompile()'
