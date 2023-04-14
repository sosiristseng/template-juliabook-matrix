FROM ghcr.io/sosiristseng/juliabook:1.8.5.7

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# System packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends git parallel && \
    rm -rf /var/lib/apt/lists/*

# Julia environment
COPY *.toml ./
COPY src/ src

RUN julia --color=yes --project="" -e 'import Pkg; Pkg.add("IJulia"); Pkg.build("IJulia")' && \
    julia --color=yes --project=@. -e 'import Pkg; Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'

CMD ["jupyter-book"]
