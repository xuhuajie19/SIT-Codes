/****************************************************************** 
*Name: Huajie Xu
*Purpose: Final Exam Q3
*Date:
*Description: 
*
*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

libname sasdata "/folders/myfolders/sasuser.v94/SAS_data/";

proc copy in=sasdata out=work;
    select admission;
run;

proc freq data=admission;
	table rank;
run;

proc logistic data=admission descending;
	class rank (ref='1');
    model admit=rank gre gpa; 
run;