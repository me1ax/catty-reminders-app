FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN playwright install chromium --with-deps

ARG DEPLOY_REF=NA
ENV DEPLOY_REF=${DEPLOY_REF}

COPY app/ ./app/
COPY static/ ./static/
COPY templates/ ./templates/
COPY config.json .
COPY inputs.json .
COPY testlib/ ./testlib/

EXPOSE 8181

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8181"]
