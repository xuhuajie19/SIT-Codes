/****************************************************************** 
*Name: Huajie Xu
*Purpose: Regression
*Date:
*Description: 
*
*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

libname sasdata "/folders/myfolders/sasuser.v94/SAS_data/";

proc copy in=sasdata out=work;
    select depression lung;
run;

proc reg data = lung;
    model FVC_father = Age_father Height_father;
run;

proc reg data = depression;
    model cat_total = income sex age;
run;

proc reg data = lung;
    model height_oldest_child = age_oldest_child height_mother height_father;
run;