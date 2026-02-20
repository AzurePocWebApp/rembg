FROM python:3.11-slim

WORKDIR /rembg

RUN pip install --upgrade pip && \
    pip install poetry poetry-dynamic-versioning

RUN apt-get update && apt-get install -y curl git && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . .

ENV POETRY_DYNAMIC_VERSIONING_BYPASS=0.0.0

RUN poetry config virtualenvs.create false && \
    poetry install --extras "cpu cli" --without dev

RUN rembg d u2net

EXPOSE 7000
ENTRYPOINT ["rembg"]
CMD ["s", "-h", "0.0.0.0", "-p", "7000"]
