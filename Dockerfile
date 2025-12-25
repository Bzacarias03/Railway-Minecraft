FROM eclipse-temurin:17-jre-alpine

WORKDIR /minecraft

# Install bash (Alpine uses sh by default, but run.sh needs bash)
RUN apk add --no-cache bash

# Copy all server files
COPY . .

# Make run.sh executable
RUN chmod +x run.sh

# Create persistent data directory and startup script
RUN mkdir -p /minecraft/data && \
    echo '#!/bin/bash' > /minecraft/start.sh && \
    echo 'mkdir -p /minecraft/data/world' >> /minecraft/start.sh && \
    echo 'mkdir -p /minecraft/data/logs' >> /minecraft/start.sh && \
    echo 'rm -rf /minecraft/world /minecraft/logs' >> /minecraft/start.sh && \
    echo 'ln -sf /minecraft/data/world /minecraft/world' >> /minecraft/start.sh && \
    echo 'ln -sf /minecraft/data/logs /minecraft/logs' >> /minecraft/start.sh && \
    echo 'exec ./run.sh nogui' >> /minecraft/start.sh && \
    chmod +x /minecraft/start.sh

EXPOSE 25565

CMD ["/minecraft/start.sh"]