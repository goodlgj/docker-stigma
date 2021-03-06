FROM centos:6

MAINTAINER heeminChae / version: 1.0

# Add Default User Account : stigma / Change Password : root, stigma
RUN groupadd -g 500 -r stigma && useradd -u 500 -r -m -g stigma stigma && \
        echo "stigma:S2curity" | chpasswd && \
        echo "root:Su2crity" | chpasswd

# Install default package
RUN yum -y install tuned tune-util vim bzip2 gzip unzip tar git wget curl hostname sysvinit-tools util-linux net-tools epel-release openssh* sudo yum-utils

# Install mysql package 
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install mysql-server mysql pwgen supervisor bash-completion psmisc; yum clean all

# sudo stigma sshd
RUN echo stigma ALL=/etc/init.d/sshd >> /etc/sudoers
RUN sed -i 's/Defaults    requiretty/\#Defaults    requiretty/g' /etc/sudoers

# TimeZone Change : KST
RUN mv /etc/localtime /etc/localtime.bak && \
        ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Set Env
ENV PROJECT_HOME="/app" \
    MYSQL_HOME="/app/mysql"  \
    MYSQL_LOGS="/app/mysql/logs" \
    WORK=/work

#make default directory
RUN mkdir -p $PROJECT_HOME && mkdir -p $WORK && chown -R stigma:stigma $PROJECT_HOME && \
    mkdir -p $MYSQL_HOME/logs

ADD ./post.sh $WORK/post.sh
ADD ./config_mysql.sh $WORK/config_mysql.sh
ADD ./supervisord.conf $WORK/supervisord.conf

# COPY supervisord.conf
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./post.sh	$WORK

# RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers

RUN chmod 755 $WORK/post.sh
RUN chmod 755 $WORK/config_mysql.sh
RUN $WORK/config_mysql.sh

# compress Application
RUN cd $WORK && tar cvfz $WORK/mysql.tar.gz $MYSQL_HOME && rm -rf $PROJECT_HOME

# mysql port
EXPOSE 3306

# Start Container
CMD ["/work/post.sh"]
