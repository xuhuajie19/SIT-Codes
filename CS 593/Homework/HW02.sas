/****************************************************************** 
*Name: Huajie Xu
*Purpose: Calculate the page rank of the given network
*Date:
*Description:
*
*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

/*PageRank Solution*/
data Arcs;
    infile datalines;
    input Node $ A B C D E F G x y;
    datalines;

A   0   1   1   0   0   1   0   0   0
B   1   0   0   1   0   0   0   0   0
C   0   0   0   1   0   1   0   0   0
D   1   1   0   0   1   0   0   0   0
E   0   0   0   0   0   0   0   0   0
F   0   0   0   0   1   0   0   0   0
G   0   1   0   0   0   0   0   0   1
x   0   0   0   0   0   0   1   0   0
y   0   0   0   0   0   0   0   1   0
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
              ,f/sum(f) as x6
              ,g/sum(g) as x7
              ,x/sum(x) as x8
              ,y/sum(y) as x9
        from Arcs
    ;
quit;

/*Since there are 9 nodes, the initial vector v0 has 9 components, each 1/9*/
data rank_p;
    x1=1/9; 
    x2=1/9;
    x3=1/9;
    x4=1/9;
    x5=1/9;
    x6=1/9;
    x7=1/9;
    x8=1/9;
    x9=1/9;
    output;
run;


proc iml;
    use matrix_1;
    read all var { x1 x2 x3 x4 x5 x6 x7 x8 x9 } into M;
    print M;
    
    use rank_p;
    read all var { x1 x2 x3 x4 x5 x6 x7 x8 x9 } into rank_p1;
    print rank_p1;
    rank_p = t(rank_p1);
    print rank_p; 
    
    rank_p2 = M*rank_p;
    print rank_p2;     
    
    rank_p50 = (M**50)*rank_p;
    print rank_p50;

quit;
