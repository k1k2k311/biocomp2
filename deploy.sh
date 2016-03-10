#!/bin/sh

cp frontend/src/cgi/hello.pl ~/WWW/cgi-bin/
mkdir ~/WWW/cgi-bin/Biocomp2/
cp middle/src/perl/Biocomp2/Middle.pm ~/WWW/cgi-bin/Biocomp2/
cp database/src/perl/Biocomp2/DataAccess.pm ~/WWW/cgi-bin/Biocomp2/
chmod -R 755 ~/WWW/cgi-bin/

