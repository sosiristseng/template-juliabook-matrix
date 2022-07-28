# Jupyter book template for Julia Jupyter notebooks

- Gitlab: https://gitlab.com/ww-juliabooks/template-juliabook-docker
- GitHub: https://github.com/sosiristseng/template-juliabook-docker

## Jupyter Book

[Jupyter book](https://jupyterbook.org/index.html) creates a beautiful website from Markdown and Jupyter Notebook files.

## CI/CD

GitHub actions and GitLab CI/CD are setup to build and publish the website whenever changes are committed.

- Execution results are executed on the fly so you can push notebooks with empty output cells and received the results once the pipeline is completed.
- Execution results are cached so only the edited notebooks would be executed to save CI time.

### On GitHub

Click `Use this template` green button to copy this repository to your place.

Open your repository settings => Pages => GitHub Pages
=> Build and deployment => Source, Select `GitHub actions`


## Auto update

This template is able to periodically update Julia dependencies and make a MR (PR) if the docker images and notebooks are built successfully.

- For GitHub: [See the instructions](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs) in `create pull request` action about how to trigger further CI workflows.
- For GitLab: Requires `GIT_PUSH_TOKEN` [CI/CD variable](https://docs.gitlab.com/ee/ci/variables/index.html), a PAT with `write_repo` access.
