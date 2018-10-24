FROM continuumio/miniconda3

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y libxrender-dev

# Python packages from conda environment.yml file
ADD environment.yml /tmp/environment.yml
RUN chmod -R 777 /tmp

# add conda to bashrc
RUN echo 'export PATH="/opt/conda/bin:$PATH"' >> ~/.bashrc
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

# source bashrc
RUN source ~/.bashrc

# create conda env from environment.yml
ADD environment.yml /tmp/environment.yml
WORKDIR /tmp
RUN conda env create
WORKDIR /
RUN rm -rf /tmp
