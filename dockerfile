FROM zaproxy/zap-weekly:latest

# Set zap user and group IDs
USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3-pip git firefox-esr && \
    pip3 install --break-system-packages --upgrade wheel setuptools && \
    git clone https://github.com/Grunny/zap-cli.git /opt/zap-cli && \
    pip3 install --break-system-packages /opt/zap-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix permissions for zap user
RUN mkdir -p /zap/wrk && \
    chown -R zap:zap /zap/wrk && \
    chmod -R 777 /zap/wrk

# Set Firefox environment variables
ENV DISPLAY=:99

# Switch back to zap user
USER zap

ENTRYPOINT ["/bin/bash"]
