FROM zaproxy/zap-weekly:latest

# Set zap user and group IDs
USER root

# Fix permissions for zap user
RUN mkdir -p /zap/wrk && \
    chown -R zap:zap /zap/wrk && \
    chmod -R 777 /zap/wrk \
    chmod -R 777 /zap && \

# Switch back to zap user
USER zap

ENTRYPOINT ["/bin/bash"]