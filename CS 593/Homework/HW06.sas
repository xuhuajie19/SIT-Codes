/****************************************************************** 
*Name: Huajie Xu
*Purpose: Logistic Regression
*Date:
*Description: 
*
*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

libname sasdata "/folders/myfolders/sasuser.v94/SAS_data/";

proc copy in=sasdata out=work;
    select depression;
run;

data depression_b;
    set depression;
    if Cat_total>=16 then depressed=1;
    else depressed=0;
    log_income=log(income);
run;

proc logistic data=depression_b descending;
    model depressed=age sex log_income beddays health; 
run;