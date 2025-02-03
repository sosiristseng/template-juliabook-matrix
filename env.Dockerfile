FROM julia:1.11.3 AS julia
FROM python:3.13.1-slim

# System config
ENV JULIA_CI='true'
ENV JULIA_NUM_THREADS='auto'
# Let PythonCall use built-in python
ENV JULIA_CONDAPKG_BACKEND='Null'
ENV JULIA_PATH='/usr/local/julia/'
ENV PATH=${JULIA_PATH}/bin:${PATH}
COPY --from=julia ${JULIA_PATH} ${JULIA_PATH}

WORKDIR /app

# Python dependencies
COPY requirements.txt .
RUN pip install --no-cache nbconvert -r requirements.txt

# Julia dependencies
COPY Project.toml Manifest.toml ./
COPY src/ src
RUN julia --color=yes -e 'using Pkg; Pkg.add(["IJulia", "Literate", "JSON"]); import IJulia; IJulia.installkernel("Julia", "--project=@.")' && \
    julia --color=yes --project=@. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
