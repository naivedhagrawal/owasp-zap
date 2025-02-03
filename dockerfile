FROM zaproxy/zap-weekly:latest

# Set user to root for administrative tasks
USER root

# Create and set permissions for /zap/wrk directory
RUN mkdir -p /zap/wrk && \
    chown -R zap:zap /zap/wrk && \
    chmod -R 755 /zap/wrk

# Install Python3, virtualenv, and required dependencies
RUN apt-get update && \
    apt-get install -y python3-pip python3-venv --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment and install zap2sarif
RUN python3 -m venv /zap/venv && \
    /zap/venv/bin/pip install --no-cache-dir zap2sarif

# Set PATH to include virtual environment's bin directory
ENV PATH="/zap/venv/bin:$PATH"

# Switch back to the zap user for security
USER zap

# Keep the entrypoint as /bin/bash
ENTRYPOINT ["/bin/bash"]
