FROM python:3.11.1-slim

# System packages
# RUN apt-get update && apt-get install -y git parallel --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Julia
ENV JULIA_NUM_THREADS "auto"
ENV JULIA_PATH /usr/local/julia/
ENV PATH $JULIA_PATH/bin:$PATH
COPY --from=julia:1.8.5 ${JULIA_PATH} /usr/local/

# Python dependencies
# e.g. matplotlib
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir -U nbconvert

# Julia environment
COPY Project.toml Manifest.toml ./
# If you have src folder for the custom package, uncomment this
# COPY src/ src
RUN julia --project="" -e 'import Pkg; Pkg.add("IJulia"); Pkg.build("IJulia")' && \
    julia --project=@. -e 'import Pkg; Pkg.instantiate()'

CMD ["julia"]
