#!/bin/sh
#
#!/bin/bash
#Function:
#  No.4 of the second exercise
#History:
#  2013/03/19 zyy
echo "Please input scores, less than 5 socres:"
read -a score_arr
sorted_arr=($(printf '%s\n' "${score_arr[@]}"|sort -n -r))
declare -i i
for (( i=0; $i<${#sorted_arr[@]}; i=$i+1 ))
do
 case ${sorted_arr[i]} in
   ?|?\.*|[1-5]?|[1-5]?\.*)
   score_rank[i]="Failed!";;
   6?|6?\.*)
        score_rank[i]="Passed!";;
   7?|7?\.*)
        score_rank[i]="Medium!";;
   8?|8?\.*)
        score_rank[i]="Good!";;
   100|100\.0|9?|9?\.*)
        score_rank[i]="Excellent!";;
   *)
   score_rank[i]="Not a Score";;
esac
done
declare -i j
for (( j=0; $j<${#sorted_arr[@]}; j=$j+1 ))
do
   echo "${sorted_arr[j]}  ${score_rank[j]}"
done

#编写一段 shell 程序完成:根据从键盘输入的学生成绩,显示相应的成绩标准,也可以同时
#输入多个成绩，最多为5 个，以空格分隔。
#分出不及格、及格、中、良和优秀等.
#要有对*.?分的识别能力.
#如果是多个成绩需要从高到低进行显示.
#所使用的shell 语句不限.
#以程序行数最少为最佳.