FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
#FROM neurodebian:nd16.04
MAINTAINER Soichi Hayashis <hayashis@iu.edu>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y vim tightvncserver xfce4 python-pip
RUN pip install indexed_gzip --upgrade

EXPOSE 5900
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y vim mesa-utils tightvncserver xfce4 wget

RUN wget -O- http://neuro.debian.net/lists/xenial.us-tn.full | tee /etc/apt/sources.list.d/neurodebian.sources.list
#RUN apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
RUN apt-get update && apt-get install -y --allow-unauthenticated fsleyes 

#https://sourceforge.net/projects/virtualgl/files/2.6/virtualgl_2.6_amd64.deb/download
#release note > https://github.com/VirtualGL/virtualgl/blob/master/ChangeLog.md
ADD virtualgl_2.6_amd64.deb /
RUN dpkg -i /virtualgl_2.6_amd64.deb

ADD startvnc.sh /
ADD xstartup /root/.vnc/xstartup
ENV USER=root X11VNC_PASSWORD=override

CMD ["/startvnc.sh"]

