FROM zaproxy/zap-weekly:latest

# Set zap user and group IDs
USER root

# Create a virtual environment and install zap-cli
RUN apt-get update && apt-get install -y python3-venv && \
    python3 -m venv /opt/zap-cli-venv && \
    /opt/zap-cli-venv/bin/pip install --no-cache-dir zap-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables to use zap-cli easily
ENV PATH="/opt/zap-cli-venv/bin:$PATH"

# Fix permissions for zap user
RUN mkdir -p /zap/wrk && \
    chown -R zap:zap /zap/wrk && \
    chmod -R 777 /zap/wrk

# Switch back to zap user
USER zap

ENTRYPOINT ["/bin/bash"]