FROM python:3.10.5-slim-buster

LABEL maintainer="Matthew Skinner (Elastic)"

# Update and install system packages
RUN apt update -y && \
  apt install --no-install-recommends -y -q \
  git libpq-dev python-dev && \
  apt clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set environment variables & working directory
ENV DBT_DIR /dbt
WORKDIR $DBT_DIR

# clone dbt repo
RUN mkdir dbt; \
  cd dbt; \
  git clone https://github.com/elastic/dbt.git; \
  pip install -U pip; \
  pip install -r dbt/requirements.txt

# Run dbt
ENTRYPOINT [ "dbt" ]