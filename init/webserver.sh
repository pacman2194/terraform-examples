#!/bin/bash

apt update -y && apt upgrade -y && apt autoremove -y
apt install -y build-essential git

cd /
mkdir /public_html
cat >/public_html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
<title>Hello World HTML</title>
</head>
<body>
<h1>Hello World</h1>
</body>
</html>
EOF

git clone https://unix4lyfe.org/git/darkhttpd
cd darkhttpd
make
./darkhttpd /public_html --port 80 &
