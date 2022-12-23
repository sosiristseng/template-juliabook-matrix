# Jupyter book template for Julia Jupyter notebooks

## Jupyter Book

[Jupyter book](https://jupyterbook.org/index.html) creates a beautiful website from Markdown and Jupyter Notebook files.

## CI/CD

GitHub actions build and publish the website whenever changes are pushed.

- Execution results are executed on the fly so you can push notebooks with empty output cells and received the results once the pipeline is completed.
- Execution results are cached so only the edited notebooks would be executed to save CI time.

Click `Use this template` green button to copy this repository to your place.

Open your repository settings => Pages => GitHub Pages
=> Build and deployment => Source, Select `GitHub actions`

## Auto update

### Julia dependencies

This template is able to periodically update Julia dependencies and make a PR if the docker images and notebooks are built successfully.

- For GitHub: [See the instructions](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs) in `create pull request` action about how to trigger further CI workflows.

### Other dependencies

Other dependency updates are handled by the [Renovate bot](https://docs.renovatebot.com/). Please enable [Renovate Github APP](https://github.com/apps/renovate).
