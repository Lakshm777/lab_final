FROM python:3.13.5
RUN pip install flask
COPY . /app
WORKDIR /app

ENTRYPOINT ["python"]
CMD ["app.py"]
