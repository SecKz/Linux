#!/bin/sh
#
awk 'BEGIN{  
    test = 100;  
    total=0;  
  
    while(i<=test){  
        total+=i;  
        i++;  
    }  
    print "total = ", total;  
  
  
    print  
    test=100;  
    total=0;  
    i=0;  
  
    do{  
        total+=i;  
        i++;  
    }while(i<=test);  
    print "total = ", total;  
}'  

