FROM zaproxy/zap-weekly:latest

# Set user to root for administrative tasks
USER root

# Create and set permissions for /zap/wrk directory
RUN mkdir -p /zap/wrk && \
    chown -R zap:zap /zap/wrk && \
    chmod -R 755 /zap/wrk

# Install Python3 and required dependencies
RUN apt-get update && \
    apt-get install -y python3-pip --no-install-recommends && \
    pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir zap2sarif && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the zap user for security
USER zap

# Keep the entrypoint as /bin/bash
ENTRYPOINT ["/bin/bash"]