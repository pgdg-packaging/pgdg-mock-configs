config_opts['chroot_setup_cmd'] = 'install patterns-devel-base-devel_rpm_build pgdg-srpm-macros'
config_opts['macros']['%__brp_check_rpaths'] = "/usr/bin/true"

config_opts['dist'] = 'suse.lp156'  # only useful for --resultdir variable subst
config_opts['releasever'] = '15.6'
config_opts['macros']['%dist'] = '.suse.lp156'
config_opts['package_manager'] = 'dnf'
config_opts['ssl_ca_bundle_path'] = '/var/lib/ca-certificates/ca-bundle.pem'
config_opts['extra_chroot_dirs'] = [ '/run/lock', ]

config_opts['bootstrap_image'] = 'registry.opensuse.org/opensuse/leap-dnf:{{ releasever }}'

# Due to the nature of the OpenSUSE mirroring system, we can not use
# metalinks easily and also we can not rely on the fact that baseurl's
# always work (issue #553) -- by design we need to expect a one minute
# repository problems (configured four attempts means 3 periods of 20s).
config_opts['package_manager_max_attempts'] = 4
config_opts['package_manager_attempt_delay'] = 20

config_opts['description'] = 'PGDG openSUSE Leap {{ releasever }}'

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

#################################
# PGDG openSUSE Leap repositories	#
#################################

# PGDG openSUSE Leap stable common repository for all PostgreSQL versions

[pgdg-common]
name=PostgreSQL common RPMs for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/common/suse/sles-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# We provide extra packages to support some RPMs in the PostgreSQL RPM repo, like
# consul, haproxy, etc.

[pgdg-sles15-extras]
name=Extra packages to support some RPMs in the PostgreSQL RPM repo openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/extras/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# PGDG openSUSE Leap stable repositories

[pgdg18]
name=PostgreSQL 18 for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/18/suse/sles-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg17]
name=PostgreSQL 17 for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/17/suse/sles-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg16]
name=PostgreSQL 16 for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/16/suse/sles-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg15]
name=PostgreSQL 15 for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/15/suse/sles-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg14]
name=PostgreSQL 14 for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/14/suse/sles-$releasever-$basearch
enabled=1
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# PGDG openSUSE Leap testing common repository

[pgdg-common-testing]
name=PostgreSQL common testing RPMs for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/testing/common/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# PGDG openSUSE Leap Updates Testing repositories (These packages should not be used in production).
# Available for v15 and above.

[pgdg19-updates-testing]
name=PostgreSQL 19 for openSUSE Leap $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/testing/19/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg18-updates-testing]
name=PostgreSQL 18 for openSUSE Leap $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/testing/18/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg17-updates-testing]
name=PostgreSQL 17 for openSUSE Leap $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/testing/17/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg16-updates-testing]
name=PostgreSQL 16 for openSUSE Leap $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/testing/16/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg15-updates-testing]
name=PostgreSQL 15 for openSUSE Leap $releasever - $basearch - Updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/testing/15/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# PGDG openSUSE Leap stable common SRPM repository for all PostgreSQL versions

[pgdg-source-common]
name=PostgreSQL common SRPMs for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/common/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# PGDG openSUSE Leap testing common SRPM repository for all PostgreSQL versions

[pgdg-common-srpm-testing]
name=PostgreSQL common testing SRPMs for openSUSE Leap $releasever - $basearch
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/testing/common/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# Source RPMs (SRPM), and their testing repositories.
# Available for v15 and above.

[pgdg19-source-updates-testing]
name=PostgreSQL 19 for openSUSE Leap $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/testing/19/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg18-source]
name=PostgreSQL 18 for openSUSE Leap $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/18/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg18-source-updates-testing]
name=PostgreSQL 18 for openSUSE Leap $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/testing/18/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg17-source]
name=PostgreSQL 17 for openSUSE Leap $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/17/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg17-source-updates-testing]
name=PostgreSQL 17 for openSUSE Leap $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/testing/17/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg16-source]
name=PostgreSQL 16 for openSUSE Leap $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/16/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg16-source-updates-testing]
name=PostgreSQL 16 for openSUSE Leap $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/testing/16/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg15-source]
name=PostgreSQL 15 for openSUSE Leap $releasever - $basearch - Source
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/15/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg15-source-updates-testing]
name=PostgreSQL 15 for openSUSE Leap $releasever - $basearch - Source updates testing
baseurl=https://download.postgresql.org/pub/repos/zypp/srpms/testing/15/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# Debuginfo/debugsource repositories for the common repo

[pgdg-common-debuginfo]
name=PostgreSQL common RPMs for openSUSE Leap $releasever - $basearch - Debuginfo
baseurl=https://zypp-debuginfo.postgresql.org/debug/common/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# Debuginfo/debugsource repositories for stable repos

[pgdg18-debuginfo]
name=PostgreSQL 18 for openSUSE Leap $releasever - $basearch - Debuginfo
baseurl=https://zypp-debuginfo.postgresql.org/debug/18/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg17-debuginfo]
name=PostgreSQL 17 for openSUSE Leap $releasever - $basearch - Debuginfo
baseurl=https://zypp-debuginfo.postgresql.org/debug/17/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg16-debuginfo]
name=PostgreSQL 16 for openSUSE Leap $releasever - $basearch - Debuginfo
baseurl=https://zypp-debuginfo.postgresql.org/debug/16/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg15-debuginfo]
name=PostgreSQL 15 for openSUSE Leap $releasever - $basearch - Debuginfo
baseurl=https://zypp-debuginfo.postgresql.org/debug/15/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg14-debuginfo]
name=PostgreSQL 14 for openSUSE Leap $releasever - $basearch - Debuginfo
baseurl=https://zypp-debuginfo.postgresql.org/debug/14/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# Debuginfo/debugsource repositories for testing repos
# Available for v15 and above.

[pgdg19-updates-testing-debuginfo]
name=PostgreSQL 19 for openSUSE Leap $releasever - $basearch - Debuginfo testing
baseurl=https://zypp-debuginfo.postgresql.org/testing/debug/19/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg18-updates-testing-debuginfo]
name=PostgreSQL 18 for openSUSE Leap $releasever - $basearch - Debuginfo testing
baseurl=https://zypp-debuginfo.postgresql.org/testing/debug/18/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg17-updates-testing-debuginfo]
name=PostgreSQL 17 for openSUSE Leap $releasever - $basearch - Debuginfo testing
baseurl=https://zypp-debuginfo.postgresql.org/testing/debug/17/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg16-updates-testing-debuginfo]
name=PostgreSQL 16 for openSUSE Leap $releasever - $basearch - Debuginfo testing
baseurl=https://zypp-debuginfo.postgresql.org/testing/debug/16/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

[pgdg15-updates-testing-debuginfo]
name=PostgreSQL 15 for openSUSE Leap $releasever - $basearch - Debuginfo testing
baseurl=https://zypp-debuginfo.postgresql.org/testing/debug/15/suse/sles-$releasever-$basearch
enabled=0
gpgcheck=1
gpgkey=https://zypp.postgresql.org/keys/PGDG-RPM-GPG-KEY-SLES15
repo_gpgcheck = 1

# repos

[opensuse-leap-oss]
name=openSUSE Leap $releasever - $basearch - OSS
baseurl=https://cdn.opensuse.org/distribution/leap/$releasever/repo/oss/
enabled=1
gpgkey=file:///usr/share/distribution-gpg-keys/opensuse/RPM-GPG-KEY-openSUSE-2022
       file:///usr/share/distribution-gpg-keys/opensuse/RPM-GPG-KEY-openSUSE-Backports-2023
       file:///usr/share/distribution-gpg-keys/suse/RPM-GPG-KEY-SuSE-SLE-15
       file:///usr/share/distribution-gpg-keys/suse/RPM-GPG-KEY-SuSE-SLE-Main-2023
gpgcheck=1

[opensuse-leap-oss-update]
name=openSUSE Leap $releasever - $basearch - OSS - Updates
baseurl=https://cdn.opensuse.org/update/leap/$releasever/oss/
enabled=1
gpgkey=file:///usr/share/distribution-gpg-keys/opensuse/RPM-GPG-KEY-openSUSE-2022
gpgcheck=1

[opensuse-leap-sle-update]
name=openSUSE Leap $releasever - $basearch - Updates from SUSE Linux Enterprise
baseurl=https://cdn.opensuse.org/update/leap/$releasever/sle/
enabled=1
gpgkey=file:///usr/share/distribution-gpg-keys/suse/RPM-GPG-KEY-SuSE-SLE-Main-2023
gpgcheck=1

[opensuse-leap-sle-backports-update]
name=openSUSE Leap $releasever - $basearch - Updates from Backports for SUSE Linux Enterprise
baseurl=https://cdn.opensuse.org/update/leap/$releasever/backports/
enabled=1
gpgkey=file:///usr/share/distribution-gpg-keys/opensuse/RPM-GPG-KEY-openSUSE-Backports-2023
gpgcheck=1
"""
