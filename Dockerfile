FROM python:3.7.4
WORKDIR /usr/src/app
ADD . /usr/src/app

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Shanghai

RUN yum install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

RUN chmod 777 /usr/src/app/chromedriver
## install python requirements 
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple pyspider --no-cache-dir -r requirements.txt
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

## install ntpdate, not accept but saving code
#RUN echo 'deb http://mirrors.163.com/debian/ jessie main non-free contrib \
#	deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib \
#	deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib' > /etc/apt/sources.list \
#	&& apt-get update\
#	&& apt-get install ntpdate -y \


#EXPOSE 5010

CMD [ "python", "run.py" ]
#ENTRYPOINT [ "python", "run.py" ]
