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

# for f in `find ./Classi -name "*.php"`;do
# ed $f << END
# 13i
#   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
#         integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
# .
# w
# q
# END

# done



# for f in `find ./Docenti -name "*.php"`;do
# echo $f
# ed $f << END
# 85i
#   <?php include '../header.html';?>
# .
# w
# q
# END

# done

for f in `find ./Classi -name "*.php"`;do
 #mv "$f" ./Aule/"$(basename "$f" .html).php"
sed -i '18,83d' $f
done
# #sed -i 's/html/php/g' ./Docenti/*
