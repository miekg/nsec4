#!/bin/bash

# download all external entities and put them
# in the bibxml directory and modify the ENTITY
# lines to pick up these local ones.

mkdir -p bibxml

for f in "$@"; do
    while read entity; do
        entity="${entity%\>}"
        entity="${entity%\"}"
        entity="${entity#\"}"
        entity="${entity%\'}"
        entity="${entity#\'}"
        ( cd bibxml ; wget $entity".xml" )
        elements=(${entity//\// })
        localentity="${elements[-2]}/${elements[-1]}"
        echo $0: replacing $entity with $localentity >&2
        sed -i "s|$entity|$localentity|" "$f"
    done < <( awk '/ENTITY.*http/ { print $5 } ' "$f" )
done
