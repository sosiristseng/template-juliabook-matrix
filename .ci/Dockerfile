FROM registry.gitlab.com/sosiristseng/docker-juliabook:1.7.3.12

ENV LC_ALL C.UTF-8

WORKDIR /usr/src/app

# Build Julia environment
COPY Project.toml Manifest.toml ./
# COPY src/ src # If you have this
RUN julia --threads=auto --color=yes --project=@. -e 'import Pkg; Pkg.instantiate()'

CMD ["jupyter-book"]
