/****************************************************************** 
*Name: Huajie Xu
*Purpose: PCA analysis
*Date:
*Description: Using matrix operations, apply PCA analysis on variables cat_01 to cat_20 in the depression dataset. 
*Create a new dataset replacing the original C1 to C20 variable with principal components.
*
*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

libname sasdata "/folders/myfolders/sasuser.v94/SAS_data/";
proc copy in=sasdata out=work;
   select depression;
run;

title "PCA Analysis"; 
title2 "Univariate Analysis"; 
proc univariate data=depression ;
   var Cat_01 - Cat_20;
run;
title " "; 
title2 " "; 

*** Normalize the data ***;
proc standard DATA=depression
              MEAN=0 STD=1 
              OUT=depression_z;
   var Cat_01 - Cat_20;
run;

title "PCA Analysis";   
title2 " Corrolation between Variables"; 
proc corr data=depression_z; 
   var Cat_01 - Cat_20;
run;

** creat an output dataset with scores **;
title "PCA Analysis";   
title2 " Output Dataset"; 
proc princomp data=depression_z  out=depression_pca;
   var Cat_01 - Cat_20;
run;

** Delete Cat_XX columns **;
data depression_pca;
  set depression_pca (drop=Cat_:);
run;