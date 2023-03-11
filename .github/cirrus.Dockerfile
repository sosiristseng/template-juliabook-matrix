FROM python:3.11.2-slim

# Supress warning emitted by parallel
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Julia
ENV JULIA_CI true
ENV JULIA_NUM_THREADS "auto"
ENV JULIA_PATH /usr/local/julia/
ENV JULIA_DEPOT_PATH /srv/juliapkg/
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia:1.8.5 ${JULIA_PATH} ${JULIA_PATH}

WORKDIR /app

# System packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends git parallel && \
    rm -rf /var/lib/apt/lists/*

# Python dependencies. e.g. matplotlib
COPY requirements.txt ./
COPY .github/requirements.txt ./requirements-jb.txt
RUN pip install --no-cache-dir -U pip && pip install --no-cache-dir -r requirements.txt -r requirements-jb.txt

# Julia environment
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes --project="" -e 'import Pkg; Pkg.add("IJulia"); using IJulia; installkernel("Julia", "--project=@.")' && \
    julia --color=yes --project=@. -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'

CMD ["jupyter-book"]
