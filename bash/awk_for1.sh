#!/bin/sh
#
awk 'BEGIN{
   for(i=1; i<=5; i++){
       array[i] = i*2 - 1;
   }

   for(i in array){
       print i" = " array[i];
   }
}'

echo -------------------------------------------
  
awk 'BEGIN{  
    for(i=1; i<=3; i++){  
        array[i] = i*i;  
        print i" = "array[i];  
    }  
  
    print  
    for(i=1; i<=length(array); i++){  
        if(array[i] > 5){  # larger 5 then break  
            break;  
        }  
        print i" = "array[i];  
    }  
}'  
