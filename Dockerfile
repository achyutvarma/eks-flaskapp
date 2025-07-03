FROM python:3.12-slim
WORKDIR /flaak-app
COPY flask-app.py .
RUN pip install flask
EXPOSE 80
CMD ["python", "flask-app.py"]