#!/bin/sh

while [ true ];
do
	curl -s "$URL";
	sleep $TIME;
done
