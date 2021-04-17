#!/bin/sh
version="0.1.0"

if [ "$(uname)" = "Darwin" ]; then
  os="darwin"
elif [ "$(expr substr "$(uname -s)" 1 5)" = "Linux" ]; then
  os="linux"
else
  echo "Your plataform ($(uname -a)) is not supported."
  exit 1
fi

arch="amd64"
if [ "$(command -v dpkg)" != "" ] && [ "$(dpkg --print-architecture)" = "arm*" ]; then
  arch="arm"
fi


mkdir _tmp
cd _tmp

curl -L https://github.com/sethvargo/terraform-provider-berglas/releases/download/v${version}/terraform-provider-berglas_${version}_${os}_$(arch).zip > berglass.zip
unzip berglass.zip

mkdir -p $HOME/.terraform.d/plugins
mv "terraform-provider-berglas_v${version}" $HOME/.terraform.d/plugins/terraform-provider-berglas

cd ../
rm -rf _tmp

terraform init
