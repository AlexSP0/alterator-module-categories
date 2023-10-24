%define _unpackaged_files_terminate_build 1

Name: alterator-module-categories
Version: 0.1.0
Release: alt1

Summary: categories interface
License: GPLv2+
Group: Other
URL: https://github.com/AlexSP0/alterator-module-categories

Source0: %name-%version.tar

%description
categories interface for alterator operating via D-Bus.

%prep
%setup

%install
mkdir -p %buildroot%{_datadir}/dbus-1/interfaces
mkdir -p %buildroot%{_sysconfdir}/polkit-1/rules.d
mkdir -p %buildroot%{_datadir}/alterator/backends
mkdir -p %buildroot%{_datadir}/alterator/scripts

install -v -p -m 644 -D ru.basealt.alterator.categories.xml %buildroot%{_datadir}/dbus-1/interfaces
install -v -p -m 644 -D 49-alterator-module-categories.rules %buildroot%{_sysconfdir}/polkit-1/rules.d
install -v -p -m 644 -D categories.backend %buildroot%{_datadir}/alterator/backends
install -v -p -m 644 -D *.sh %buildroot%{_datadir}/alterator/scripts

%files
%{_datadir}/alterator/backends/categories.backend
%{_datadir}/alterator/scripts/*.sh
%{_datadir}/dbus-1/interfaces/ru.basealt.alterator.categories.xml
%{_sysconfdir}/polkit-1/rules.d/49-alterator-module-categories.rules

%changelog
* Mon Oct 23 2023 Kozyrev Yuri <kozyrevid@altlinux.org> 0.1.0-alt1
- initial build
