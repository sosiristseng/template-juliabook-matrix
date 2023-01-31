FROM julia:1.8.5

# Julia
ENV JULIA_CI true
ENV JULIA_DEPOT_PATH /srv/juliapkg/

CMD ["julia"]
