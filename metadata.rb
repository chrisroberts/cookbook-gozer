maintainer       "Chris Roberts"
maintainer_email "chrisroberts.code@gmail.com"
license          "Apache 2.0"
description      "Build my workstation"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"

supports 'ubuntu' # but really, we are building off xubuntu

depends 'i3'
depends 'ohai'
depends 'apt'
