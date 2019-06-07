# Common scripts

Common scripts and utilities created by Jose Luis Mantilla.

## validation-so.sh

* Valida S.O usando `hostnamectl` o el archivo release de cada distro.
* Valida arquitectura con `uname -m` o tambien con `getconf LONG_BIT` = "64"`

`uname --help || getconf -a   => Para ver mas opciones`

## bash-menu.sh

* Menu profesional con bash usando getops con opciones largas y cortas creando la opciones --help.

## ./python-dialog.sh

http://pythondialog.sourceforge.net/

## Validacion de scripts

```bash
$ bash -n script.sh     => Syntax checking and errors.
$ bash -x script.sh     => Debug expanding each simple command and expanding it
$ bash -v script.sh     => Print shell input lines as they are read (verbose).
$ bash -e script.sh     => Exit  immediately  if a single command exits with a  non-zero status.
$ bash -u script.sh     => prints an error when a variables is unset.
$ shellcheck script.sh  => Linting tool for sh/bash scripts
```
## Optimizacion de pdfs

Parametros
```
PDFSETTINGS **parameters**
  -dPDFSETTINGS=/screen lower quality, smaller size.
  -dPDFSETTINGS=/ebook for better quality, but slightly larger pdfs.
  -dPDFSETTINGS=/prepress output similar to Acrobat Distiller "Prepress Optimized" setting
  -dPDFSETTINGS=/printer selects output similar to the Acrobat Distiller "Print Optimized" setting
  -dPDFSETTINGS=/default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file
```
Comando
```
find /home/joseluis/pdf-test -type f -name "*.pdf" -printf "%f\n" | while read -r file
do
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -dQUIET -sOutputFile="new_$file" "$file"
  #rm "$file"
  mv "new_$file" "output/$file"
done
```

## Testing

man test -> Check file types and compare values

```bash
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
```

## Unit test

serverspec  => https://serverspec.org/resource_types.html

Inspec      => https://www.inspec.io/docs/reference/migration/Goss

## Documentations

Read the docs https://docs.readthedocs.io

Make docs     https://www.mkdocs.org/

Docusaurus    https://docusaurus.io/

Electron    https://electronjs.org

## Mensajeria para equipos

Slack, Mattermost, Rocket.chat, Ryver and Zulip.

## man example  

Rules to create man documentation -> man 7 mdoc
install -g 0 -o 0 -m 644 ami.1 /usr/share/man/man1/
gzip /usr/share/man/man1/ami.1

## 80 Linux Monitoring tools

https://blog.serverdensity.com/80-linux-monitoring-tools-know/

### Record terminal from python

pip install TermRecord
TermRecord -o /tmp/session.html bash

## Azure

```bash
sudo apt-get update && sudo apt-get install -y libssl-dev libffi-dev python-dev python-pip
pip install setuptools wheel 
pip install ansible[azure]
sudo apt install ansible
```
Now, follow the steps for installing azure-cli
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

Creating an Azurevm from localhost

$ az login
* It creates the ~/.azure folder with the login

Azure from VSCode

Plugins to install:
* Azure CLI Tools
* Azure Account

### .Net en Ubuntu

Download the SDK or Runtime at https://dotnet.microsoft.com/download

Example doing downgrade to dotnet-sdk-2.2 package.
```bash
sudo apt cache policy dotnet-sdk-2.2
sudo apt install dotnet-sdk-2.2=2.2.102-1
sudo apt-mark hold dotnet-sdk-2.2
```

### Nodejs

sudo apt install nodejs

```bash
nvm install 6
nvm list
```
