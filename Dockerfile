FROM python:3.13.5
RUN pip install -r requirements.txt
COPY . /app
WORKDIR /app

ENTRYPOINT ["python"]
CMD ["app.py"]
