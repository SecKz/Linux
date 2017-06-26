#!/bin/sh
#
awk 'BEGIN{  
    test = 80;  
    if(test >= 90){  
        print "good";  
    }else if(test >= 80){  
        print "soso";  
    }else{  
        print "fail";  
    }  
}'  