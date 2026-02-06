FROM julia:1.12.0

# System config
ENV OPENBLAS_NUM_THREADS=1
ENV JULIA_CI='true'
ENV JULIA_NUM_THREADS='auto'
# GitHub runner CPU arch
ENV JULIA_CPU_TARGET='generic;icelake-server,clone_all;znver3,clone_all'
# Set CondaPkg environment path in ~/.julia/conda_environments/jlpy
ENV JULIA_CONDAPKG_ENV=@jlpy
WORKDIR /app

# Julia dependencies
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes -e 'using Pkg; Pkg.add(["Literate", "JSON"]); Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.precompile()'
