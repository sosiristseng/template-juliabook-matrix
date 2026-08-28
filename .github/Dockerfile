FROM julia:1.12.7

ENV JULIA_CI="true"
ENV JULIA_NUM_THREADS="auto"
ENV OPENBLAS_NUM_THREADS="1"
ENV JULIA_DEPOT_PATH="/srv/julia/"

# Expose the target architecture argument
ARG TARGETARCH

WORKDIR /app
COPY Project.toml Manifest.toml ./
COPY Startup/ Startup

RUN if [ "$TARGETARCH" = "amd64" ]; then \
        export JULIA_CPU_TARGET="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)"; \
    fi; \
    # You must use the variable in the SAME RUN layer, as it won't persist to the next line
    julia --project=@. --color=yes -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
