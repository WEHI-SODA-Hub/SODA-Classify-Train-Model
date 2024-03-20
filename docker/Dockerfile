FROM mambaorg/micromamba:1.5.7-bookworm-slim

COPY environment.yml /tmp/environment.yml

RUN micromamba install -n base -f /tmp/environment.yml -y && micromamba clean -ay

