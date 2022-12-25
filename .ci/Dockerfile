FROM python:3.11.1-slim

# System packages
# RUN apt-get update && apt-get install -y git parallel --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Julia
ENV JULIA_PATH /usr/local/julia/
ENV PATH $JULIA_PATH/bin:$PATH
COPY --from=julia:1.8.3 ${JULIA_PATH} /usr/local/

# Python dependencies
# e.g. matplotlib
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir nbconvert

# Julia environment
COPY Project.toml Manifest.toml ./
# COPY src/ src # If you have this
RUN julia --threads=auto --color=yes --project="" -e 'import Pkg; Pkg.add("IJulia"); Pkg.build("IJulia")' && \
    julia --threads=auto --color=yes --project=@. -e 'import Pkg; Pkg.instantiate()'

CMD ["julia"]
