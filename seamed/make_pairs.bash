#!/bin/bash

tmpfile=$(mktemp /tmp/make_pairs.XXXXXX)
jsonfile=files.js
echo "{" > $tmpfile
for filename in *.obj;
do 
    modelname=${filename%.obj};
    echo "    \"${modelname}\": {" >> $tmpfile
    echo "        \"filename\": \"${filename}\"" >> $tmpfile
    EEfilename=EE/${modelname}.txt;
    if [[ -f "$EEfilename" ]]
    then 
        echo "        ,\"EEfilename\": \"${EEfilename}\"" >> $tmpfile
    fi
    echo "    }," >> $tmpfile
done
# to avoid javascript being stupid about trailing commas lets create an empty
# tag and remove it :( 
echo "\"NOTAFILE\":{}}" >> $tmpfile
jq 'del(.NOTAFILE)' $tmpfile > $jsonfile
