#!/bin/bash
# Author: Paulo Jerônimo (@paulojeronimo, pj@paulojeronimo.info)
#
# Faz o download e verifica o SHA1SUM dos arquivos baixados. Uso:
# $ bash <(curl -sSL http://j.mp/vm-fedora-download)

host=https://googledrive.com/host/0B_tTlCk55SmjZGlNckhCRldUUDQ

for f in 00{1..COUNT} vm-fedora.sha1sum
do
    case $f in
      *[!0-9]*) :;;
      *) f=vm-fedora.7z.$f;;
    esac
    echo -e "\nBaixando $f ..."
    curl -L -C - -O $host/$f
done

if [ -f $f ]
then
    echo -e "\nVerificando o download ..."
    case `uname` in
        Darwin) sha1sum=shasum;;
        Linux) sha1sum=sha1sum;;
    esac
    if $sha1sum -c $f
    then
        echo -e "\nOk! Download concluído com sucesso!"

        echo -e "\nExtraindo a VM ..."
        if 7za x vm-fedora.7z.001
        then
            echo -e "\nOk! Extração concluída com sucesso!"
            exit
        else
            echo -e "\nErro na extração! :( Tente novamente!"
        fi
    else
        echo -e "\nErro no download! :( Tente novamente!"
    fi 
fi
exit 1
