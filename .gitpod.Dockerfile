FROM gitpod/workspace-full

RUN pyenv install 3.7-dev && pyenv global 3.7-dev
