FROM ubuntu:trusty
MAINTAINER Aditya Avanth <avant.aditya@gmail.com>

#prevent dpkg errors
ENV TERM=xterm-256color

#set mirrors to NZ
RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list

#Install ansible
Run apt-get update -qy &&\
    apt-get install -qy software-properties-common &&\
    apt-add-repository -y ppa:ansible/ansible &&\
    apt-get update -qy &&\
    apt-get install -qy ansible

#Add volumes for ansible playbooks
VOLUME /ansible
WORKDIR /ansible

#Copy probe play-book to ansible image
COPY ansible /ansible

ENTRYPOINT ["ansible-playbook"]
CMD ["site.yml"]    
    