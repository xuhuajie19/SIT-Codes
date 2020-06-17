/****************************************************************** 
*Name: Huajie Xu
*Purpose: Final Exam Q5
*Date:
*Description:
*
*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

/*Node F and G are eliminated. */
data Arcs;
    infile datalines;
    input Node $ A B C D E;
    datalines;

A   0   1   0   0   1
B   1   0   1   0   0
C   0   1   0   1   0
D   0   0   1   0   1
E   1   0   0   1   0
;
run;

/*get the transition matrix*/
proc sql;
    create table matrix_1 as
        select a/sum(a) as x1
              ,b/sum(b) as x2
              ,c/sum(c) as x3
              ,d/sum(d) as x4
              ,e/sum(e) as x5
        from Arcs
    ;
quit;

/*Since there are 5 nodes, the initial vector v0 has 5 components, each 1/5*/
data rank_p;
    x1=1/5; 
    x2=1/5;
    x3=1/5;
    x4=1/5;
    x5=1/5;
    output;
run;


proc iml;
    use matrix_1;
    read all var { x1 x2 x3 x4 x5 } into M;
    print M;
    
    use rank_p;
    read all var { x1 x2 x3 x4 x5 } into rank_p1;
    print rank_p1;
    rank_p = t(rank_p1);
    print rank_p; 
    
    rank_p2 = M*rank_p;
    print rank_p2;     
    
    rank_p50 = (M**50)*rank_p;
    print rank_p50;
    
    rank_p100=(M**100)*rank_p;
    print rank_p100 ;

quit;
