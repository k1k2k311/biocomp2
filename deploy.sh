#!/bin/sh

mkdir -p ~/WWW/cgi-bin/Biocomp2/
cp frontend/src/cgi/hello.pl ~/WWW/cgi-bin/
cp frontend/src/cgi/prog1.pl ~/WWW/cgi-bin/
cp frontend/src/cgi/search.pl ~/WWW/cgi-bin/
cp frontend/src/cgi/style.css ~/WWW/
cp frontend/src/cgi/Biocomp2/Front.pm ~/WWW/cgi-bin/Biocomp2/

cp middle/src/perl/Biocomp2/* ~/WWW/cgi-bin/Biocomp2/

cp database/src/perl/Biocomp2/DataAccess.pm ~/WWW/cgi-bin/Biocomp2/
chmod -R 755 ~/WWW/cgi-bin/

