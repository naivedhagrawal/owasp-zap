FROM zaproxy/zap-weekly:latest

# Set zap user and group IDs
USER root

# Check if Python is installed, if not, install it
RUN if ! command -v python3 &> /dev/null; then \
        apt-get update && apt-get install -y python3-pip; \
    fi && \
    pip3 install zap-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix permissions for zap user
RUN mkdir -p /zap/wrk && \
    chown -R zap:zap /zap/wrk && \
    chmod -R 777 /zap/wrk

# Switch back to zap user
USER zap

ENTRYPOINT ["/bin/bash"]