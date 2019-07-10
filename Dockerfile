
#Download base image ubuntu 18.04
FROM ubuntu:18.04
ENV PYTHONUNBUFFERED 1

# Install Essentials
RUN apt-get update && \
    apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget && \
    apt install -y software-properties-common apt-transport-https bash && \
    apt-get install -y git-core && \
    apt install -y python3.6 python3-pip && \
    pip3 install virtualenv virtualenvwrapper


RUN mkdir -p /app_ws/app
COPY requirements.txt /app_ws/
RUN pip3 install -r /app_ws/requirements.txt
COPY start.sh /app_ws/
COPY app /app_ws/app

EXPOSE 5000

WORKDIR /app_ws/
CMD ["./start.sh"]