FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
#FROM neurodebian:nd16.04
MAINTAINER Soichi Hayashis <hayashis@iu.edu>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y vim tightvncserver xfce4 python-pip wmctrl mesa-utils tightvncserver xfce4 wget freeglut3 libsdl1.2debian
#RUN pip install indexed_gzip --upgrade

EXPOSE 5900

RUN pip install --only-binary wxpython -f https://extras.wxpython.org/wxPython4/extras/linux/gtk2/ubuntu-16.04/ wxpython
RUN pip install fsleyes
RUN pip install fsleyes[extras] #not sure if we really need this or not

#https://sourceforge.net/projects/virtualgl/files/2.6/virtualgl_2.6_amd64.deb/download
#release note > https://github.com/VirtualGL/virtualgl/blob/master/ChangeLog.md
ADD virtualgl_2.6_amd64.deb /
RUN dpkg -i /virtualgl_2.6_amd64.deb

ADD startvnc.sh /
ADD xstartup /root/.vnc/xstartup
ENV USER=root X11VNC_PASSWORD=override

CMD ["/startvnc.sh"]

