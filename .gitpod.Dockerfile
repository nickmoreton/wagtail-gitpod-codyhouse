FROM gitpod/workspace-postgres

ARG PYTHON_VERSION=3.8
ARG NODE_VERSION=14
ARG POETRY_HOME=${HOME}/.poetry
ARG POETRY_VERSION=1.1.6

USER root

RUN pyenv install ${PYTHON_VERSION}; exit 0 && python global ${PYTHON_VERSION}

RUN bash -c ". .nvm/nvm.sh && nvm install ${NODE_VERSION} && nvm use ${NODE_VERSION} && nvm alias default ${NODE_VERSION}"
RUN echo "nvm use default &>/dev/null" >> ~/.bashrc.d/51-nvm-fix

ENV PATH=$PATH:${POETRY_HOME}/bin \
    PYTHONUNBUFFERED=1

EXPOSE 8080

USER gitpod

RUN wget https://raw.githubusercontent.com/python-poetry/poetry/${POETRY_VERSION}/get-poetry.py && \
    echo "eedf0fe5a31e5bb899efa581cbe4df59af02ea5f get-poetry.py" | sha1sum -c - && \
    python get-poetry.py && \
    rm get-poetry.py && \
    poetry config virtualenvs.create false
