#!/bin/sh
#
a[0]='Debian'
a[1]='Red hat'
a[2]='Ubuntu'
a[3]='Suse'

for i in ${a[*]}; do			#不能直接用$a
echo $i;
done

echo -----------------------------------------

k=0

b[((k++))]='aaaa 1111'				#不能写成b[$k++]
b[((k++))]='bbbb'
b[((k++))]='cccc 3333'
b[((k++))]='dddd'

for i in ${b[@]}; do			#不能直接用$a
echo $i;
done

echo -----------------------


declare -a Unix=('Debian' 'Red hat' 'Suse' 'Fedora' 'Centos');
for os in $Unix; do
echo $os
done

