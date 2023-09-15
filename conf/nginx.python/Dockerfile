FROM nginx

# Install common tools
RUN \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        curl \
        fcgiwrap

# Install c++ library dependency
ADD ./99-start-fcgiwrap.sh /docker-entrypoint.d/99-start-fcgiwrap.sh
