config_opts['chroot_setup_cmd'] = " install system-release bash bzip2 coreutils cpio diffutils findutils gawk glibc-minimal-langpack grep gzip info patch pgdg-srpm-macros rpm-build sed system-rpm-config tar unzip util-linux which xz"

config_opts['dist'] = 'amzn2023'  # only useful for --resultdir variable subst
config_opts['releasever'] = '2023'
config_opts['package_manager'] = 'dnf'
config_opts['extra_chroot_dirs'] = [ '/run/lock', ]
config_opts['plugin_conf']['ccache_enable'] = False
config_opts['bootstrap_image'] = 'public.ecr.aws/amazonlinux/amazonlinux:2023'


config_opts['dnf.conf'] = """
[main]
keepcache=1
debuglevel=2
reposdir=/dev/null
logfile=/var/log/yum.log
retries=20
obsoletes=1
gpgcheck=0
assumeyes=1
syslog_ident=mock
syslog_device=
install_weak_deps=0
metadata_expire=0
best=1
protected_packages=
user_agent={{ user_agent }}

#########################################
# PGDG Amazon Linux repositories.	#
#########################################

# PGDG Amazon Linux stable common repository for all PostgreSQL versions

[pgdg-common]
name=PostgreSQL common RPMs for Amazon Linux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/common/amzn/amzn-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

# We provide extra package to support some RPMs in the PostgreSQL RPM repo, like
# consul, haproxy, etc.

[pgdg-amzn2023-extras]
name=Extra packages to support some RPMs in the PostgreSQL RPM repo Amazon Linux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/extras/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

# PGDG Amazon Linux stable repositories

[pgdg18]
name=PostgreSQL 18 for Amazon Linux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/18/amzn/amzn-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg17]
name=PostgreSQL 17 for Amazon Linux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/17/amzn/amzn-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg16]
name=PostgreSQL 16 for Amazon Linux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/16/amzn/amzn-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg15]
name=PostgreSQL 15 for Amazon Linux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/15/amzn/amzn-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg14]
name=PostgreSQL 14 for Amazon Linux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/14/amzn/amzn-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

# PGDG Amazon Linux Source RPMs (SRPMS) repositories

[pgdg-source-common]
name=PostgreSQL common for Amazon Linux $releasever - $basearch - Source
baseurl=https://dnf-srpms.postgresql.org/srpms/common/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg-amzn2023-extras-source]
name=Extra packages for Amazon Linux $releasever - $basearch - Source
baseurl=https://dnf-srpms.postgresql.org/srpms/extras/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg18-source]
name=PostgreSQL 18 for Amazon Linux $releasever - $basearch - Source
baseurl=https://dnf-srpms.postgresql.org/srpms/18/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg17-source]
name=PostgreSQL 17 for Amazon Linux $releasever - $basearch - Source
baseurl=https://dnf-srpms.postgresql.org/srpms/17/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg16-source]
name=PostgreSQL 16 for Amazon Linux $releasever - $basearch - Source
baseurl=https://dnf-srpms.postgresql.org/srpms/16/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg15-source]
name=PostgreSQL 15 for Amazon Linux $releasever - $basearch - Source
baseurl=https://dnf-srpms.postgresql.org/srpms/15/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg14-source]
name=PostgreSQL 14 for Amazon Linux $releasever - $basearch - Source
baseurl=https://dnf-srpms.postgresql.org/srpms/14/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

# Debuginfo/debugsource repositories

[pgdg-common-debuginfo]
name=PostgreSQL common RPMs for Amazon Linux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/common/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg-amzn2023-extras-debuginfo]
name=Extra packages for Amazon Linux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/extras/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg18-debuginfo]
name=PostgreSQL 18 for Amazon Linux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/18/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg17-debuginfo]
name=PostgreSQL 17 for Amazon Linux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/17/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg16-debuginfo]
name=PostgreSQL 16 for Amazon Linux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/16/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg15-debuginfo]
name=PostgreSQL 15 for Amazon Linux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/15/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

[pgdg14-debuginfo]
name=PostgreSQL 14 for Amazon Linux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/14/amzn/amzn-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://download.postgresql.org/pub/repos/yum/keys/PGDG-RPM-GPG-KEY-AMAZONLINUX
repo_gpgcheck = 1

#########################################
# Amazon Linux base repositories.	#
#########################################

[amazonlinux]
name=Amazon Linux $releasever repository - $basearch
mirrorlist=https://cdn.amazonlinux.com/al${releasever}/core/mirrors/latest/$basearch/mirror.list
enabled=1
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///usr/share/distribution-gpg-keys/amazon-linux/RPM-GPG-KEY-amazon-linux-$releasever

[amazonlinux-source]
name=Amazon Linux $releasever repository - Source packages
mirrorlist=https://cdn.amazonlinux.com/al${releasever}/core/mirrors/latest/SRPMS/mirror.list
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///usr/share/distribution-gpg-keys/amazon-linux/RPM-GPG-KEY-amazon-linux-$releasever

[amazonlinux-debuginfo]
name=Amazon Linux $releasever repository - $basearch - Debug
mirrorlist=https://cdn.amazonlinux.com/al${releasever}/core/mirrors/latest/debuginfo/$basearch/mirror.list
enabled=0
repo_gpgcheck=0
type=rpm
gpgcheck=1
gpgkey=file:///usr/share/distribution-gpg-keys/amazon-linux/RPM-GPG-KEY-amazon-linux-$releasever
"""
