import pandas as pd
import re
from uuid import uuid4
from pathlib import Path
import firebase_admin
from firebase_admin import credentials, firestore


cwd = Path(__file__).parent
data_path = cwd / "times.xlsx"
credential_file = cwd / "credentials.json"

cred = credentials.Certificate(credential_file)
firebase_admin.initialize_app(cred)
db = firestore.client()

df = pd.read_excel(data_path)

time_re = re.compile(r"(\d{2}):(\d{2})(\s{0,1})-(\s{0,1})(\d{2}):(\d{2})")


def series_to_faculty(series):
    name = series["Team"].split("-", maxsplit=1)[0]
    match = re.match(r"[a-zA-Z]{1,2}(?=[0-9])", name, re.IGNORECASE)
    return match.group(0).lower() if match else None


def get_team_times(row, time_columns):
    times = {}
    for time in time_columns:
        cell = row[time]
        if cell.lower().strip() == "pause":
            continue
        faculty = cell.split("-", maxsplit=2)[1].strip().lower()
        times[faculty] = time.split("-", maxsplit=1)[0].strip()
    return times


def get_json(series):
    return {
        "name": series["Team"],
        "faculty": series["faculty"],
        "times": series["times"],
    }


df["faculty"] = df.apply(series_to_faculty, axis=1)
time_columns = [col for col in df.columns if time_re.match(col)]
df["times"] = df.apply(get_team_times, time_columns=time_columns, axis=1)
df["id"] = df.apply(lambda _: str(uuid4()), axis=1)

for _, row in df.iterrows():
    doc = db.collection("teams").document(row["id"])
    doc.set(get_json(row))
