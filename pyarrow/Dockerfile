FROM mambaorg/micromamba
RUN micromamba install -y -c conda-forge \
  pyarrow pandas boto3 pymongo \
  && micromamba clean --all --yes
