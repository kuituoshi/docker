FROM changel/alpine:3.8

MAINTAINER changel <changel@changel.cn>

RUN set -ex \
  && apk add --no-cache vsftpd curl

ENV SET_VSFTPD_listen=YES \
	SET_VSFTPD_port_enable=YES \
	SET_VSFTPD_seccomp_sandbox=NO \
	SET_VSFTPD_background=NO \
	SET_VSFTPD_ascii_upload_enable=YES \
	SET_VSFTPD_ascii_download_enable=YES \
	SET_VSFTPD_anonymous_enable=YES \
	SET_VSFTPD_anon_world_readable_only=YES \
	SET_VSFTPD_anon_upload_enable=NO \
	SET_VSFTPD_anon_mkdir_write_enable=NO \
	SET_VSFTPD_anon_root=/data/ftp \
	SET_VSFTPD_local_enable=YES \
	SET_VSFTPD_write_enable=YES \
	SET_VSFTPD_local_umask=022 \
	SET_VSFTPD_pasv_enable=YES \
	SET_VSFTPD_pasv_min_port=50000 \
	SET_VSFTPD_pasv_max_port=50010 \
	SET_VSFTPD_chroot_local_user=YES \
	SET_VSFTPD_chroot_list_enable=NO \
	SET_VSFTPD_allow_writeable_chroot=YES \
	GEN_VSFTPD_USERNAME=admin \
	GEN_VSFTPD_PASSWORD=admin

ADD auto-config.sh /usr/local/bin/

CMD ["auto-config.sh"]