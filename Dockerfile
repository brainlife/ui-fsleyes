FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu16.04
MAINTAINER Soichi Hayashis <hayashis@iu.edu>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	vim tightvncserver xfce4 python-pip wmctrl mesa-utils tightvncserver xfce4 wget freeglut3 libsdl1.2debian

EXPOSE 5900

RUN pip install --only-binary wxpython -f https://extras.wxpython.org/wxPython4/extras/linux/gtk2/ubuntu-16.04/ wxpython
RUN pip install fsleyes

#not sure if we really need this or not
RUN pip install fsleyes[extras] 

#https://sourceforge.net/projects/virtualgl/files/2.6/virtualgl_2.6_amd64.deb/download
#release note > https://github.com/VirtualGL/virtualgl/blob/master/ChangeLog.md
ADD virtualgl_2.6_amd64.deb /
RUN dpkg -i /virtualgl_2.6_amd64.deb

ADD startvnc.sh /
ADD xstartup /root/.vnc/xstartup
ENV USER=root X11VNC_PASSWORD=override

#RUN apt-get install -y xfce4-goodies
RUN apt-get remove -y xfce4-panel

CMD ["/startvnc.sh"]

