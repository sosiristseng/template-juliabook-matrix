FROM julia:1.8.5

ENV JULIA_CI true
ENV JULIA_PKG_PRECOMPILE_AUTO 0
ENV JULIA_NUM_THREADS "auto"

CMD ["julia"]
