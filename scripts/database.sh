#!/usr/bin/env bash

ROOT="/var/www/html/pbox14/";
SERVERCONFIG="/var/www/html/pbox14/_serverconfig/";
FILENAME=${SERVERCONFIG}"/database.php"

if [ -d ${ROOT} ]; then
	if [ ! -d ${SERVERCONFIG} ]; then
		sudo mkdir ${SERVERCONFIG}
		echo ${SERVERCONFIG} "Folder Created"
	fi

    > ${FILENAME}

	OUTPUT="$(aws secretsmanager get-secret-value --secret-id pbadmin | jq -r '.SecretString')"
	KEYS="$(echo ${OUTPUT} | jq -r 'keys | .[]')"


	echo "<?php" >> ${FILENAME}


	for VARIABLE in ${KEYS}
	do
		echo $\db["'default'"]["'"${VARIABLE}"'"] "=" $(echo ${OUTPUT} | jq '.'${VARIABLE})";" >> ${FILENAME}
	done

else
	echo ${ROOT} "Folder Not Found"
fi
