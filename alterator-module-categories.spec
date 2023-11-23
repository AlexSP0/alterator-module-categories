%define _unpackaged_files_terminate_build 1

Name: alterator-module-categories
Version: 0.1.0
Release: alt1

Summary: Categories interface for alterator browser.
License: GPLv2+
Group: Other
URL: https://github.com/AlexSP0/alterator-module-categories

BuildArch: noarch

Source0: %name-%version.tar

%description
Object categories interface for alterator browser operating via D-Bus.

%prep
%setup

%install
mkdir -p %buildroot%_datadir/dbus-1/interfaces
mkdir -p %buildroot%_sysconfdir/polkit-1/rules.d
mkdir -p %buildroot%_datadir/alterator/backends
mkdir -p %buildroot%_datadir/alterator/scripts
mkdir -p %buildroot%_datadir/alterator/objects/global/scripts

install -v -p -m 644 -D ru.basealt.alterator.categories.xml %buildroot%_datadir/dbus-1/interfaces
install -v -p -m 644 -D 49-alterator-module-categories.rules %buildroot%_sysconfdir/polkit-1/rules.d
install -v -p -m 644 -D categories.backend %buildroot%_datadir/alterator/backends
install -v -p -m 755 -D *.sh %buildroot%_datadir/alterator/objects/global/scripts

%files
%_datadir/alterator/backends/categories.backend
%_datadir/alterator/objects/global/scripts/*.sh
%_datadir/dbus-1/interfaces/ru.basealt.alterator.categories.xml
%_sysconfdir/polkit-1/rules.d/49-alterator-module-categories.rules

%changelog
* Tue Nov 14 2023 Aleksey Saprunov <sav@altlinux.org> 0.1.0-alt1
- initial build
