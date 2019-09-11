FROM python:3.7.4
WORKDIR /usr/src/app
ENV TZ Asia/Shanghai

RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
  gnupg \
    --no-install-recommends

RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update
## xdg-icon-resource: No writable system icon directory found.
RUN apt-get install -y --force-yes --no-install-recommends hicolor-icon-theme
RUN apt-get install -y \
    google-chrome-stable \
    --no-install-recommends
    

ADD . /usr/src/app
ENV DEBIAN_FRONTEND noninteractive
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
