FROM centos:6.7

#base setup
RUN set -ex \
    && curl -sSL http://mirrors.aliyun.com/repo/epel-6.repo -o /etc/yum.repos.d/epel.repo \
    && curl -sSL http://mirrors.aliyun.com/repo/Centos-6.repo -o /etc/yum.repos.d/CentOS-Base.repo \
    && sed -i 's/^enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum install -y supervisor

#config svn
RUN rpm --rebuilddb \
	&& yum install -y subversion mod_ssl mod_dav_svn \
	&& mkdir -p /usr/local/svn
COPY supervisord.conf /etc/
COPY svn.conf /etc/httpd/conf.d/


#expose and command
EXPOSE 443
CMD ["supervisord"]