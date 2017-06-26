#!/bin/sh
#将文件的行进行merge
#常用选项：
#-d:  指定两个文件的行合并后的分割符
#-s: 将每个文件合并为一行，而不是按行进行合并

cat << EOF > a.txt
aaaa
bbbb
cccc dddd
EOF

cat << EOF > b.txt
11111 
22222
3333333
444444444
EOF

paste a.txt b.txt	 #将两个文件的每行合并
echo ------------------------------------
paste -d: a.txt b.txt	#将两个文件的每行合并，分隔符为:
echo ------------------------------------
paste -s a.txt
echo ------------------------------------
paste -s a.txt b.txt	 #将file1的内容合并为一行，将file2的内容合并为一行