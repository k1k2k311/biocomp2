#!/bin/sh

mkdir -p ~/WWW/cgi-bin/Biocomp2/
cp frontend/src/cgi/hello.pl ~/WWW/cgi-bin/
cp middle/src/perl/Biocomp2/Middle.pm ~/WWW/cgi-bin/Biocomp2/
cp database/src/perl/Biocomp2/DataAccess.pm ~/WWW/cgi-bin/Biocomp2/
chmod -R 755 ~/WWW/cgi-bin/

