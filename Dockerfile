# Dockerfile - FastAPI + Uvicorn (production)
FROM python:3.11-slim


# system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
build-essential \
libpq-dev \
&& rm -rf /var/lib/apt/lists/*


WORKDIR /app


# install pip first to cache
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt


# copy
COPY . /app


ENV PORT=8080
EXPOSE 8080


# runtime user (optional)
RUN useradd -m appuser && chown -R appuser /app
USER appuser


CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]