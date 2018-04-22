# Common
Common scripts and utilities created by Jose Luis Mantilla.

## validation-so.sh

* Valida S.O usando `hostnamectl` o el archivo release de cada distro.
* Valida arquitectura con `uname -m` o tambien con `getconf LONG_BIT` = "64"`

uname --help || getconf -a   => Para ver mas opciones

## bash-menu.sh

* Menu profesional con bash usando getops con opciones largas y cortas creando la opciones --help.

## ./python-dialog.sh
http://pythondialog.sourceforge.net/

## Validacion de scripts
$ bash -n script.sh     => Syntax checking and errors.
$ bash -x script.sh     => Debug expanding each simple command and expanding it
$ bash -v script.sh     => Print shell input lines as they are read (verbose).
$ bash -e script.sh     => Exit  immediately  if a single command exits with a  non-zero status.
$ bash -u script.sh     => prints an error when a variables is unset.
$ shellcheck script.sh  => Linting tool for sh/bash scripts

## Testing
man test -> Check file types and compare values
[joseluis@soporte ~]$ test -e "/etc/motd"
[joseluis@soporte ~]$ echo $?
0
[joseluis@soporte ~]$ test -e "/etc/motds"
[joseluis@soporte ~]$ echo $?
1
[joseluis@soporte ~]$ [ -e /etc/motdsx ]
[joseluis@soporte ~]$ echo $?
1
[joseluis@soporte ~]$ [ -e /etc/motd ]
[joseluis@soporte ~]$ echo $?
0

## Unit test
serverspec  => https://serverspec.org/resource_types.html
Inspec      => https://www.inspec.io/docs/reference/migration/
Goss

## 80 Linux Monitoring tools -> https://blog.serverdensity.com/80-linux-monitoring-tools-know/

## Record terminal from python
pip install TermRecord
TermRecord -o /tmp/session.html
