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
add_bootstrap_req(){
for f in `find ./Classi -name "*.php"`;do
ed $f << END
20i
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous">
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous">
    </script>
.
w
q
END

done

}

add_bootstrap(){
for f in `find ./Classi -name "*.php"`;do
ed $f << END
13i
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
.
w
q
END

done

}
add_header_table(){
for f in `find ./Classi -name "*.php"`;do
ed $f << END
43i
                <th class='mathema'>
                    &nbsp;
                </th>

                <Th class='mathema' scope="col" NOWRAP COLSPAN=1 ROWSPAN=1>
                    LUN
                <Th class='mathema' scope="col" NOWRAP COLSPAN=1 ROWSPAN=1>
                    MAR
                <th class='mathema' scope="col" NOWRAP COLSPAN=1 ROWSPAN=1>
                    MER
                <th class='mathema' scope="col" NOWRAP COLSPAN=1 ROWSPAN=1>
                    GIO
                <th class='mathema' scope="col" NOWRAP COLSPAN=1 ROWSPAN=1>
                    VEN
.
w
q
END

done

}
add_header(){
for f in `find ./Docenti -name "*.php"`;do
echo $f
ed $f << END
85i
  <?php include '../header.html';?>
.
w
q
END

done
}

#Remove row from 44 and 57
do_remove_row_class(){
for f in `find ./Classi -name "*.php"`;do
 #mv "$f" ./Aule/"$(basename "$f" .html).php"
sed -i '44,57d' $f
done
}

#change extensions
do_change_extensions(){
for f in `find ./Classi -name "*.html"`;do
 mv "$f" ./Classi/"$(basename "$f" .html).php"
done
}


do_replace_occurency(){
for f in `find ./Docenti -name "*.html"`;do
 sed -i 's/html/php/g' ./Docenti/*
 sed -i 's/header.php/header.html/g' ./Docenti/*
 sed -i 's/footer.php/footer.html/g' ./Docenti/*

done
}

do_replace_table_header(){
for f in `find ./Classi -name "*.php"`;do

sed -i  's/<TABLE BORDER=2 WIDTH="80%" CELLSPACING=0 CELLPADDING=4>/<TABLE CELLSPACING=0 style="float:center" class="table table-hover table-borderless table-responsive text-center">/g' $f

done
}

do_replace_first_column(){
for f in `find ./Classi -name "*.php"`;do
sed -i  's/<TD class='\''mathema'\'' NOWRAP>/<Th class='\''mathema'\'' NOWRAP  style="position:sticky">/g' $f
done
}

do_replace_first_occurency(){
    for f in `find ./Classi -name "*.php"`;do
    sed -i '0,/<TR ALIGN=CENTER VALIGN=MIDDLE>/s/<TR ALIGN=CENTER VALIGN=MIDDLE>/<TR ALIGN=CENTER VALIGN=MIDDLE class="thead-light">/' $f

done
}

#do_remove_row_class
#add_header_table
do_replace_first_column