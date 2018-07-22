#!/bin/bash

#Validacion de sistema operativo
if $(command -v hostnamectl) >/dev/null ; then
    OS=`hostnamectl |grep -i operating`
    case $OS in
        *Fedora*) echo "Fedora";;
        *Ubuntu*) echo "Ubuntu";;
        *Amazon*) echo "Amazon";;
        *Centos*) echo "Centos";;
    esac
else
    OS=`grep -i name /etc/*-release|head -1`
fi
echo $OS

#Validacion de arquitectura
if [ $(uname -m) == 'x86_64' ]; then  # `getconf LONG_BIT` = "64"
  echo "64-bit codigo aqui"
else
  echo "32-bit codigo aqui"
fi
