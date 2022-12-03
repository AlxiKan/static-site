#! /bin/bash

cd pages/
echo "# List of Posts:" > posts.md
for file in *.md; do
	[ -e "$file" ] || continue
	if [ ${file} != "index.md" ] && [ ${file} != "about.md" ] && [ ${file} != "posts.md" ]; then
		echo "- ### [${file::len-3}](${file::len-3}.html)" >> posts.md
	fi
done

for file in *.md; do
	[ -e "$file" ] || continue
	cat layout0.txt > temp.txt
	if [ ${file} = "index.md" ]; then
		echo "   My Static Site for HCI" >> temp.txt
	else
		name=${file^}
		echo "   ${name::len-3}" >> temp.txt
	fi
	cat layout1.txt $file layout2.txt >> temp.txt
	mv temp.txt temp.md
	pandoc -s -f markdown temp.md --css=../static/styles.css -o ../templates/${file::len-3}.html
	rm temp.md
done

cd ..
