#!/bin/bash

for file in $@;
do
    jq . $file | sponge $file
done
