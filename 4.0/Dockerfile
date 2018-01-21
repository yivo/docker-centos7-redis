FROM centos:7

 # Update database and installed packages.
RUN yum -y update \
 \
 # Install CentOS Linux Software Collections release file.
 && yum -y install centos-release-scl \
 \
 # Install build tools.
 && yum -y install which file devtoolset-7-make devtoolset-7-gcc \
 \
 # Download Redis source code.
 && curl -sL http://download.redis.io/releases/redis-4.0.6.tar.gz | tar xz -C /tmp \
 \
 # Change working directory to Redis source.
 && cd /tmp/redis-4.0.6 \
 \
 # Configure Redis to listen to all interfaces.
 && sed -i "s|^bind 127\.0\.0\.1|# \0|g" redis.conf \
 \
 # Disable Redis protected mode which is enabled by default but is not needed in context of Docker.
 && sed -i "s/protected-mode yes/protected-mode no/" redis.conf \
 && sed -i "s/define CONFIG_DEFAULT_PROTECTED_MODE 1/define CONFIG_DEFAULT_PROTECTED_MODE 0/" src/server.h \
 \
 # Enable Append Only File persistent mode.
 # See https://redis.io/topics/persistence
 && sed -i "s/appendonly no/appendonly yes/" redis.conf \
 \
 # Build Redis.
 && scl enable devtoolset-7 "make -j $(nproc)" \
 && scl enable devtoolset-7 "make install PREFIX=/usr/local" \
 \
 # Initialize Redis home directory and copy default configuration files.
 && mkdir -p /usr/local/redis \
 && cp /tmp/redis-4.0.6/redis.conf    /usr/local/redis/redis-server.conf \
 && cp /tmp/redis-4.0.6/sentinel.conf /usr/local/redis/redis-sentinel.conf \
 \
 # Check installation.
 && redis-server -v \
 && redis-sentinel -v

VOLUME  /usr/local/redis
WORKDIR /usr/local/redis

ADD https://github.com/krallin/tini/releases/download/v0.16.1/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

EXPOSE 6379
CMD ["redis-server", "/usr/local/redis/redis-server.conf"]
