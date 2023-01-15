FROM ghcr.io/sosiristseng/template-juliabook:latest

COPY --chown=1000:1000 . /home/jojo
USER jojo

CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
