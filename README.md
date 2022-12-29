# Jupyter book template for Julia Jupyter notebooks

Click `Use this template` green button to copy this repository to your account.

## Jupyter Book

[Jupyter book](https://jupyterbook.org/index.html) creates a beautiful website from Markdown and Jupyter Notebook files.

## CI/CD

Whan changes are pushed to the GitHub repo, GitHub actions will build and publish the website. Execution results are executed on the fly so you can push notebooks with empty output cells and obtain the execution results.

To enable GitHub pages for the generated website:
Open your repository settings => Pages => GitHub Pages
=> Build and deployment => Source, Select `GitHub actions`

## Auto update Julia dependencies

This example repository can periodically update Julia dependencies and make a PR if the notebooks are executed successfully.

[See the instructions](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs) for how to trigger CI workflows in a PR. In this repo, I use a custom [GitHub APP](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#authenticating-with-github-app-generated-tokens) to generate a temporary token.

## Renovate

Other dependency updates (e.g. GitHub actions, python packages) are handled by the [Renovate bot](https://docs.renovatebot.com/). Please enable [Renovate Github APP](https://github.com/apps/renovate) to use it.
