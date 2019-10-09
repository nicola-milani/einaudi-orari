#!/bin/bash
IFS='
'
#set -f

#copy all source files in to tmp
do_copy_to_tmp(){
    rm -r ./TMP/  2> /dev/null
    mkdir -p ./TMP
    cp -r ./SOURCE/* ./TMP/
    rm ./TMP/Classi/*Copia.html 2> /dev/null
    rm ./TMP/Docenti/*Copia.html 2> /dev/null

}

do_delete_header(){
    DIR=$1
    #Remove row from 1 to 29
    for f in `find ./TMP/$DIR/ -name "*.php"`;do
        sed -i '1,29d' "$f"
    done
}
do_delete_first_row(){
    DIR=$1
    #Remove row from 1 to 29
    for f in `find ./TMP/$DIR/ -name "*.php"`;do
        sed -i '14,32d' "$f"
    done
}
do_remove_tag(){
    DIR=$1
    for f in `find ./TMP/$DIR/ -name "*.php"`;do
        sed  -i 's/NOWRAP//g' $f
        sed  -i 's/TD/td/g' $f
        sed  -i 's/TR/tr/g' $f
        sed  -i 's/TABLE/table/g' $f
        sed  -i 's/style="position:sticky"//g' $f
        sed  -i 's/ALIGN=CENTER VALIGN=MIDDLE//g' $f
        sed  -i 's/style="float:center"//g' $f
        sed  -i 's/<center>//g' $f
        sed  -i 's/<\/center>//g' $f
        sed  -i 's/<CENTER>//g' $f
        sed  -i 's/<\/CENTER>//g' $f
        sed  -i 's/<style>//g' $f
        sed  -i 's/WIDTH="15%"//g' $f
        # sed  -i 's/LUN/LUN<\/td>/g' $f
        # sed  -i 's/MAR/MAR<\/td>/g' $f
        # sed  -i 's/MER/MER<\/td>/g' $f
        # sed  -i 's/GIO/GIO<\/td>/g' $f
        # sed  -i 's/VEN/VEN<\/td>/g' $f

        
        # sed  -i 's/COLSPAN=1//g' $f
        # sed  -i 's/COLSPAN=6//g' $f
        # sed  -i 's/ROWSPAN=1//g' $f
      #  sed  -i 's/<p id = '\''mathema'\''>&nbsp;<p>/<p id = '\''mathema'\''>&nbsp;<\/p>/g' $f

    done
}

#change extensions
do_change_extensions(){
    DIR=$1
    for f in `find ./TMP/$DIR/ -name "*.html"`;do
        sed  -i 's/html/php/g' $f
        mv "$f" ./TMP/$DIR/"$(basename "$f" .html).php"
    done
}

do_copy_templates(){
    cp -r ./CODE/* ./TMP/
}

do_add_header(){
    DIR=$1
    for f in `find ./TMP/$DIR/ -name "*.php"`;do
    ed $f << END
1i
<html>
    <head>
        <?php include '../href.html';?>
    </head>
    <body>
        <?php include '../header.html';?>
        <div align="center">
.
w
q
END

done
}

do_replace_table_header(){
DIR=$1
for f in `find ./TMP/$DIR/ -name "*.php"`;do

sed -i  's/<table BORDER=2 WIDTH="80%" CELLSPACING=0 CELLPADDING=4>/<table cellspacing=0 class="table table-hover table-borderless table-responsive text-center">/g' $f

done
}

do_replace_first_column(){
    DIR=$1
for f in `find ./TMP/$DIR/ -name "*.php"`;do
sed -i  's/<td class = '\''mathema'\'' >/<th class='\''mathema'\'' scope="row" >/g' $f
done
}

do_close_tagp(){
DIR=$1
for f in `find ./TMP/$DIR/ -name "*.php"`;do

    sed -i '0,/<p>/s/<p>/<\/p>/' $f
    ed $f << END
10i
</div>
    <div align="center">
.
w
q
END
done
}

do_add_first_row(){
    DIR=$1
for f in `find ./TMP/$DIR/ -name "*.php"`;do

ed $f << END
16i
  <tr  class="thead-light">
                <th class='mathema' scope="row">
                    &nbsp;
                </th>

                <th class='mathema' scope="col" >
                    LUN
                <th class='mathema' scope="col" >
                    MAR
                <th class='mathema' scope="col" >
                    MER
                <th class='mathema' scope="col" >
                    GIO
                <th class='mathema' scope="col" >
                    VEN

            </tr>
            <tbody>
                <tr>
.
w
q
END
done
}

do_replace_footer(){
    DIR=$1
    for f in `find ./TMP/$DIR/ -name "*.php"`;do
   
   
    ed -s $f <<< $'-7,$d\nwq'    
cat >> $f << QWE
        </div>

<?php include '../footer.html';?>
</body>
</html>
QWE
    done
}
#Define Main
echo "copia in cartella temporanea"
do_copy_to_tmp

echo "converti da html a php"
do_change_extensions Classi
do_change_extensions Docenti
do_change_extensions Aule


echo "rimuovi header"
do_delete_header Classi
do_delete_header Docenti
do_delete_header Aule

echo "rimuovi tag obsoleti"
do_remove_tag Classi
do_remove_tag Docenti
do_remove_tag Aule

echo "copia template nuovi"
do_copy_templates

echo "Aggiungi nuova intestazione"
do_add_header Classi
do_add_header Docenti
do_add_header Aule

echo "Cambia intestazione tabella"
do_replace_table_header Classi
do_replace_table_header Docenti
do_replace_table_header Aule

echo "Elimina prima riga tabella"
# do_delete_first_row Classi
# do_delete_first_row Docenti
# do_delete_first_row Aule

echo "Chiudi i tag paragrafo aperti"
do_close_tagp Classi
do_close_tagp Docenti
do_close_tagp Aule

echo "Sostituisci tag prima colonna "
do_replace_first_column Classi
do_replace_first_column Docenti
do_replace_first_column Aule

echo "Aggiungi nuova prima riga "
# do_add_first_row Classi
# do_add_first_row Docenti
# do_add_first_row Aule

echo "Aggiungi footer"
do_replace_footer Classi
do_replace_footer Docenti
do_replace_footer Aule

          

cp -r ./TMP/* ./OUTPUT/

