FROM apache/superset
# Switching to root to install the required packages
USER root
RUN pip install "elasticsearch-dbapi>=0.2.9, <0.3.0"
# Switching back to using the `superset` user
ENV SUPERSET_SECRET_KEY=SUPERSET_DEMO
USER superset
