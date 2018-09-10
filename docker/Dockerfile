FROM ubuntu:18.04
MAINTAINER bhaas@broadinstitute.org

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y gcc g++ perl python automake make cmake less vim \
                                       wget git curl libdb-dev \
                                       zlib1g-dev bzip2 libncurses5-dev \
                                       texlive-latex-base \
                                       default-jre \
                                       python-pip python-dev \
                                       gfortran \
                                       build-essential libghc-zlib-dev libncurses-dev libbz2-dev liblzma-dev libpcre3-dev libxml2-dev \
                                       libblas-dev gfortran git unzip ftp libzmq3-dev nano ftp fort77 libreadline-dev \
                                       libcurl4-openssl-dev libx11-dev libxt-dev \
                                       x11-common libcairo2-dev libpng-dev libreadline6-dev libjpeg8-dev pkg-config \
                                       build-essential cmake gsl-bin libgsl0-dev libeigen3-dev libboost-all-dev \
                                       libssl-dev libcairo2-dev libxt-dev libgtk2.0-dev libcairo2-dev xvfb xauth \
                                       xfonts-base apt-utils apt-transport-https gdebi-core locales



COPY installR.sh /usr/local/src

RUN /usr/local/src/installR.sh



RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

COPY install_rstudio_server.sh /usr/local/src

RUN /usr/local/src/install_rstudio_server.sh

### User setup
RUN groupadd -g 2000 training && useradd -m -u 2000 -g 2000 training
RUN echo 'training:training' | chpasswd
RUN chsh -s /bin/bash training
ENV HOME=/home/training
RUN echo "alias ll='ls -la -G'" >> /home/training/.profile
RUN usermod -G training,www-data training

RUN usermod -a -G sudo training

RUN apt-get install -y openssh-server libncurses5-dev apache2 supervisor


EXPOSE 22 80 443 8787

RUN Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("devtools", dep = TRUE)'

RUN Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("fastcluster", dep = TRUE);'
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R");library(BiocInstaller); biocLite("useful", dep = TRUE);'

##
## Seurat 2.0
##

RUN apt-get install -y libhdf5-dev


## auto-run setup

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]


############################
## more seurat configuration



RUN Rscript -e 'library(devtools); install_github("satijalab/seurat", ref = "develop");'




