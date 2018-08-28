FROM neurodebian:nd16.04
MAINTAINER Soichi Hayashis <hayashis@iu.edu>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y vim tightvncserver xfce4 

EXPOSE 5900

RUN apt-get install -y fsleyes
#RUN apt-get install -y wmctrl

ADD startvnc.sh /
ADD xstartup /root/.vnc/xstartup
ENV USER=root X11VNC_PASSWORD=override

CMD ["/startvnc.sh"]

