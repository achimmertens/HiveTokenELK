#!/bin/bash

# Dieses Script tauscht die API-Schnittstelle aus, falls die bestehende nicht mehr funktioniert
if [ $# -ne 1 ]; then
	    echo "Bitte geben Sie den Token zum Austauschen der API-Engines an."
	    echo "Beispiel: ./replace_API.sh alive"
	    exit 1
fi

# Definiere die Parameter
OLD_URL="https://herpc.kanibot.com/contracts"
NEW_URL="https://api.hive-engine.com/rpc/contracts"
sed -i 's|'$OLD_URL'|'$NEW_URL'|g' ~/elk/$1/$1curl*.sh

