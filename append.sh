#!/bin/bash

IFS='
'
set -f
for f in `find . -name "*.html"`;do
ed $f << END
12i
        <link href="../style/style.css" rel="stylesheet" type="text/css">

.
w
q
END

done
