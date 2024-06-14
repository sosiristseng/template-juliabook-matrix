FROM julia:1.10.4@sha256:b6148b3d26f9727010112b3920ec093b126dc029b2d6290b8c7341189e0567c8 as julia
FROM python:3.12.4-slim@sha256:2fba8e70a87bcc9f6edd20dda0a1d4adb32046d2acbca7361bc61da5a106a914

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
