FROM julia:1.10.3@sha256:d2375e33738225f57caa34096ad0a15c699512027931324c62ed1949d797a2ff as julia
FROM python:3.12.3-slim@sha256:afc139a0a640942491ec481ad8dda10f2c5b753f5c969393b12480155fe15a63

# Julia config
ENV JULIA_CI 'true'
ENV JULIA_NUM_THREADS 'auto'
# ENV JULIA_CPU_TARGET 'generic;znver3'
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND 'Null'
ENV JULIA_PATH '/usr/local/julia/'
ENV JULIA_DEPOT_PATH '/srv/juliapkg/'
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia ${JULIA_PATH} ${JULIA_PATH}

WORKDIR /work

# Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Julia dependencies
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes -e 'using Pkg; Pkg.add(["IJulia", "Literate", "JSON"]); import IJulia; IJulia.installkernel("Julia", "--project=@.")' && \
    julia --color=yes --project=@. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
