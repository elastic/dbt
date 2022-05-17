import os
from google.cloud import bigquery

project = os.environ["PROJECT"]
dataset = os.environ["PR_NUMBER"]

client = bigquery.Client()
QUERY = (f"drop dataset if exists {project}.{dataset};")
query_job = client.query(QUERY)
