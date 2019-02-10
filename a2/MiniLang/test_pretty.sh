cd ./programs/1-scan+parse/valid/
for sourcefile in *.min
do
	cd ../../../
	./run.sh pretty ./programs/1-scan+parse/valid/${sourcefile} > ./programs/1-scan+parse/valid/pretty_${sourcefile}
	cd - 1>/dev/null
done
