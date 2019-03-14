FROM bitnami/postgresql:11

USER root

RUN apt-get update && \
  apt-get install -y build-essential libtool autoconf unzip wget libproj-dev libgdal-dev git python libc++-dev libxml2-dev && \
  # Install libgeos-3.7.1
  cd ~ && \
  wget http://download.osgeo.org/geos/geos-3.7.1.tar.bz2 && \
  tar xvf geos-3.7.1.tar.bz2 && \
  cd geos-3.7.1 && \
  ./configure && \
  make -j $(nproc) && \
  make install && \
  # Install postgis-2.5.2
  cd ~ && \
  wget https://download.osgeo.org/postgis/source/postgis-2.5.2.tar.gz && \
  tar xzvf postgis-2.5.2.tar.gz && \
  cd postgis-2.5.2 && \
  ./configure && \
  make -j  $(nproc) && \
  make install && \
  # Install plv8
  cd ~ && \
  wget https://github.com/plv8/plv8/archive/v2.3.9.tar.gz && \
  tar -xvzf v2.3.9.tar.gz && \
  cd plv8-2.3.9/ && \
  make -j  $(nproc)  && \
  make install && \
  ldconfig && \
  # Clean up
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  rm -rf ~/geos-3.7.1.tar.bz2 ~/geos-3.7.1 ~/postgis-2.5.2.tar.gz ~/postgis-2.5.2 ~/v2.3.9.tar.gz ~/plv8-2.3.9