# Jupyter book template for Julia Jupyter notebooks

## Jupyter Book

[Jupyter book](https://jupyterbook.org/index.html) builds a website from Markdown and Jupyter Notebook files.

## CI/CD

GitLab CI/CD are setup to build and publish the website whenever changes are pushed. Execution results are executed on the fly so you can push notebooks with empty output cells and received the results once the pipeline is completed.

## Auto update

This template is able to periodically update Julia dependencies and make a MR if the docker images and notebooks are executed successfully. You'll need a personal access token (PAT) with `write_repo` access set as the `GIT_PUSH_TOKEN` [CI/CD variable](https://docs.gitlab.com/ee/ci/variables/index.html).
