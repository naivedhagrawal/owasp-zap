FROM zaproxy/zap-weekly:latest

# Set zap user and group IDs
USER root

# Fix permissions for zap user
RUN mkdir -p /zap/wrk && \
    chown -R zap:zap /zap/wrk && \
    chmod -R 777 /zap/wrk

USER root
RUN apt-get update && apt-get install -y python3-pip --no-install-recommends && \
    pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir zap2sarif && \
    rm -rf /var/lib/apt/lists/*

# Switch back to zap user
USER zap

ENTRYPOINT ["/bin/bash"]