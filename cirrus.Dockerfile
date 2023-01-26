FROM sosiristseng/docker-jupyterbook:0.13.1.7

# System packages
# RUN apt-get update && apt-get install -y git parallel --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Julia
ENV JULIA_NUM_THREADS "auto"
ENV JULIA_PATH /usr/local/julia/
ENV PATH ${JULIA_PATH}/bin:${PATH}
COPY --from=julia:1.8.5 ${JULIA_PATH} ${JULIA_PATH}

# Python dependencies e.g. matplotlib
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir -U nbconvert

# Julia environment
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes --project="" -e 'import Pkg; Pkg.add("IJulia"); using IJulia; installkernel("Julia", "--project=@.", env=Dict("JULIA_NUM_THREADS"=>"auto"))' && \
    julia --color=yes --project=@. -e 'import Pkg; Pkg.instantiate()'

CMD ["jupyter-book"]
