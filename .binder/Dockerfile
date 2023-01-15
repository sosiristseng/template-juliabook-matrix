FROM ghcr.io/sosiristseng/template-docker-juliabook:latest

COPY --chown=${NB_UID}:${NB_UID} . ${HOME}
USER ${USER}

CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
