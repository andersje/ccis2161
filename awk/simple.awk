BEGIN{ FS = ":" }
 /:0/{ print $1, $3 } 
