pgdg-mock-configs
=================

mock is a 'simple' chroot build environment manager for building RPMs: https://github.com/rpm-software-management/mock

This package includes mock configuration files for the PGDG RPM packages.

Usage:
------

- Building package on Fedora 44 and against PostgreSQL 18: sudo mock -r pgdg-fedora-44-pg17-x86_64 package.src.rpm
- Building package on Rocky 8 and against PostgreSQL 16: sudo mock -r pgdg-rocky-8-pg16-x86_64 package.src.rpm
- Building package on Rocky 9 and against PostgreSQL 17: sudo mock -r pgdg-rocky-9-pg16-x86_64 package.src.rpm
- Building package on Rocky 10 and against PostgreSQL 18: sudo mock -r pgdg-rocky-9-pg18-x86_64 package.src.rpm
- Building package on Amazon Linux 2023 and against PostgreSQL 17: sudo mock -r pgdg-amazonlinux-2023-pg17-x86_64 package.src.rpm
- Building package on openSUSE Leap 16 and against PostgreSQL 17: sudo mock -r pgdg-opensuse-leap-16-pg17-x86_64 package.src.rpm
- Building package on openSUSE Leap 15.6 and against PostgreSQL 17: sudo mock -r pgdg-opensuse-leap-15.6-pg17-x86_64 package.src.rpm

