#!/bin/bash

IFS='
'
set -f
# for f in `find . -name "*.html"`;do
# ed $f << END
# 12i
#         <link href="../style/style.css" rel="stylesheet" type="text/css">

# .
# w
# q
# END

#done


# for f in `find . -name "*.html"`;do
# ed $f << END
# 85i

#  <?php include '../header.html';?>

# .
# w
# q
# END

# done

for f in `find ./Docenti -name "*.html"`;do
#mv "$f" ./Docenti/"$(basename "$f" .html).php"
sed -i '4d' $f
done
