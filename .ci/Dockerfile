FROM python:3.10-slim

#c Set anything you link
WORKDIR /usr/src/app

# Supress warning emitted by parallel
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# System packages required by cirrus CI
RUN apt-get update && apt-get install -y git parallel --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Julia
ENV JULIA_PATH /usr/local/julia/
ENV PATH $JULIA_PATH/bin:$PATH
COPY --from=julia:1.8.0 ${JULIA_PATH} /usr/local/

# Python dependencies
COPY requirements.txt .
COPY .ci/requirements.txt requirements.ci.txt
RUN pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir -r requirements.txt -r requirements.ci.txt

# Julia environment
COPY Project.toml Manifest.toml .
# COPY src/ src # If you have this
RUN julia --threads=auto --color=yes --project="" -e 'import Pkg; Pkg.add("IJulia"); Pkg.build("IJulia")' \
&&  julia --threads=auto --color=yes --project=@. -e 'import Pkg; Pkg.instantiate()'

CMD ["jupyter-book"]
