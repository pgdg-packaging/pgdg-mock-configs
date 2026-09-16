config_opts['chroot_setup_cmd'] = " install bash bzip2 coreutils cpio diffutils findutils gawk glibc-minimal-langpack grep gzip info lua patch pgdg-srpm-macros python3 redhat-rpm-config rpm-build sed tar unzip util-linux which xz"
config_opts['macros']['%__brp_check_rpaths'] = "/usr/bin/true"

config_opts['dist'] = 'rhel8'  # only useful for --resultdir variable subst
config_opts['releasever'] = '8'
config_opts['package_manager'] = 'dnf'
config_opts['extra_chroot_dirs'] = [ '/run/lock', ]
config_opts['bootstrap_image'] = 'quay.io/rockylinux/rockylinux:8'


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
metadata_expire=0
mdpolicy=group:primary
best=1
install_weak_deps=0
protected_packages=
module_platform_id=platform:el8
user_agent={{ user_agent }}

#########################################################################
# PGDG Red Hat Enterprise Linux / Rocky / AlmaLinux repositories.	#
#########################################################################

# PGDG Red Hat Enterprise Linux / Rocky stable common repository for all PostgreSQL versions

[pgdg-common]
name=PostgreSQL common RPMs for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/common/redhat/rhel-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# Red Hat recently breaks compatibility between 8.n and 8.n+1. PGDG repo is
# affected with the LLVM packages. This is a band aid repo for the llvmjit users
# whose installations cannot be updated.

[pgdg-rhel8-sysupdates]
name=PostgreSQL Supplementary ucommon RPMs for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/common/pgdg-rhel8-sysupdates/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# We provide extra package to support some RPMs in the PostgreSQL RPM repo, like
# consul, haproxy, etc.

[pgdg-rhel8-extras]
name=Extra packages to support some RPMs in the PostgreSQL RPM repo RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/common/pgdg-rhel$releasever-extras/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# PGDG Red Hat Enterprise Linux / Rocky stable repositories:

[pgdg18]
name=PostgreSQL 18 for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/18/redhat/rhel-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg17]
name=PostgreSQL 17 for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/17/redhat/rhel-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg16]
name=PostgreSQL 16 for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/16/redhat/rhel-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg15]
name=PostgreSQL 15 for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/15/redhat/rhel-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg14]
name=PostgreSQL 14 for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/14/redhat/rhel-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# PGDG RHEL / Rocky / AlmaLinux Updates Testing common repositories.

[pgdg-common-testing]
name=PostgreSQL common testing RPMs for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/testing/common/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# PGDG RHEL / Rocky / AlmaLinux Updates Testing repositories. (These packages should not be used in production)

[pgdg18-updates-testing]
name=PostgreSQL 18 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/testing/18/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=0
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg17-updates-testing]
name=PostgreSQL 17 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/testing/17/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg16-updates-testing]
name=PostgreSQL 16 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/testing/16/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg15-updates-testing]
name=PostgreSQL 15 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/testing/15/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg14-updates-testing]
name=PostgreSQL 14 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/testing/14/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# PGDG Red Hat Enterprise Linux / Rocky SRPM testing common repository

[pgdg-source-common]
name=PostgreSQL common for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/common/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# PGDG RHEL / Rocky / AlmaLinux testing common SRPM repository for all PostgreSQL versions

[pgdg-common-srpm-testing]
name=PostgreSQL common testing SRPMs for RHEL / Rocky / AlmaLinux $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/testing/common/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# PGDG Source RPMs (SRPMS), and their testing repositories:

[pgdg18-source-updates-testing]
name=PostgreSQL 18 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/testing/18/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=0
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg17-source]
name=PostgreSQL 17 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/17/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg17-source-updates-testing]
name=PostgreSQL 17 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/testing/17/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg16-source]
name=PostgreSQL 16 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/16/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg16-source-updates-testing]
name=PostgreSQL 16 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/testing/16/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg15-source]
name=PostgreSQL 15 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/15/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg15-source-updates-testing]
name=PostgreSQL 15 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/testing/15/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg14-source]
name=PostgreSQL 14 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/14/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg14-source-updates-testing]
name=PostgreSQL 14 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/yum/srpms/testing/14/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# Debuginfo/debugsource repositories for the common repo

[pgdg-common-debuginfo]
name=PostgreSQL common RPMs for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/common/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# Debuginfo/debugsource packages for stable repos

[pgdg17-debuginfo]
name=PostgreSQL 17 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/17/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg16-debuginfo]
name=PostgreSQL 16 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/16/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg15-debuginfo]
name=PostgreSQL 15 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/15/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg14-debuginfo]
name=PostgreSQL 14 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/debug/14/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

# Debuginfo/debugsource packages for testing repos

[pgdg18-updates-testing-debuginfo]
name=PostgreSQL 18 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/testing/debug/18/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=0
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg17-updates-testing-debuginfo]
name=PostgreSQL 17 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/testing/debug/17/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg16-updates-testing-debuginfo]
name=PostgreSQL 16 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/testing/debug/16/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg15-updates-testing-debuginfo]
name=PostgreSQL 15 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/testing/debug/15/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[pgdg14-updates-testing-debuginfo]
name=PostgreSQL 14 for RHEL / Rocky / AlmaLinux $releasever - $basearch - Debuginfo
baseurl=https://dnf-debuginfo.postgresql.org/testing/debug/14/redhat/rhel-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://yum.postgresql.org/keys/PGDG-RPM-GPG-KEY-Fedora
repo_gpgcheck = 1

[epel]
name=Extra Packages for Enterprise Linux $releasever - $basearch
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-$releasever&arch=$basearch
gpgcheck=1
gpgkey=file:///usr/share/distribution-gpg-keys/epel/RPM-GPG-KEY-EPEL-$releasever
skip_if_unavailable=False

[baseos]
name=Rocky Linux $releasever - BaseOS
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=BaseOS-$releasever
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[appstream]
name=Rocky Linux $releasever - AppStream
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=AppStream-$releasever
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/AppStream/$basearch/os/
gpgcheck=1
enabled=1
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[powertools]
name=Rocky Linux $releasever - PowerTools
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=PowerTools-$releasever
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/PowerTools/$basearch/os/
gpgcheck=1
enabled=1
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[extras]
name=Rocky Linux $releasever - Extras
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=extras-$releasever
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/extras/$basearch/os/
gpgcheck=1
enabled=1
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[devel]
name=Rocky Linux $releasever - Devel WARNING! FOR BUILDROOT ONLY DO NOT LEAVE ENABLED
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=Devel-$releasever
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/Devel/$basearch/os/
gpgcheck=1
enabled=0
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[ha]
name=Rocky Linux $releasever - High Availability
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=HighAvailability-$releasever
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/HighAvailability/$basearch/os/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[resilient-storage]
name=Rocky Linux $releasever - Resilient Storage
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=ResilientStorage-$releasever
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/ResilientStorage/$basearch/os/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[plus]
name=Rocky Linux $releasever - Plus
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=rockyplus-$releasever
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/plus/$basearch/os/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[baseos-debug]
name=Rocky Linux $releasever - BaseOS - Debug
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=BaseOS-$releasever-debug
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/BaseOS/$basearch/debug/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[baseos-source]
name=Rocky Linux $releasever - BaseOS - Source
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=source&repo=BaseOS-$releasever-source
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/BaseOS/source/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[appstream-debug]
name=Rocky Linux $releasever - AppStream - Debug
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=AppStream-$releasever-debug
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/AppStream/$basearch/debug/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[appstream-source]
name=Rocky Linux $releasever - AppStream - Source
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=source&repo=AppStream-$releasever-source
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/AppStream/source/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[powertools-debug]
name=Rocky Linux $releasever - PowerTools - Debug
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=PowerTools-$releasever-debug
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/PowerTools/$basearch/debug/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[powertools-source]
name=Rocky Linux $releasever - PowerTools - Source
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=source&repo=PowerTools-$releasever-source
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/PowerTools/source/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[extras-debug]
name=Rocky Linux $releasever - Extras Debug
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=extras-$releasever-debug
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/extras/$basearch/debug/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[extras-source]
name=Rocky Linux $releasever - Extras Source
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=extras-$releasever-source
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/extras/source/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[ha-debug]
name=Rocky Linux $releasever - High Availability - Debug
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=HighAvailability-$releasever-debug
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/HighAvailability/$basearch/debug/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[ha-source]
name=Rocky Linux $releasever - High Availability - Source
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=source&repo=HighAvailability-$releasever-source
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/HighAvailability/source/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[resilient-storage-debug]
name=Rocky Linux $releasever - Resilient Storage - Debug
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=ResilientStorage-$releasever-debug
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/ResilientStorage/$basearch/debug/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[resilient-storage-source]
name=Rocky Linux $releasever - Resilient Storage - Source
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=source&repo=ResilientStorage-$releasever-source
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/ResilientStorage/source/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[devel-debug]
name=Rocky Linux $releasever - Devel Debug
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=$basearch&repo=Devel-$releasever-debug
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/Devel/$basearch/debug/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8

[devel-source]
name=Rocky Linux $releasever - Devel Source
mirrorlist=https://mirrors.rockylinux.org/mirrorlist?arch=source&repo=Devel-$releasever-source
#baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/Devel/source/tree/
gpgcheck=1
enabled=0
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-8


"""
