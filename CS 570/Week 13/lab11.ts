const readline=require('readline');
const readlines=require('readline-sync');
const fs=require('fs');
const path=require('path');

interface Queue{
    Enqueue(value);
    Dequeue();
    Front();
    IsEmpty():boolean;
}
class ArrayQueue implements Queue{
    arr=[];
    Front(){
        return this.arr[0];
    }
    Enqueue(value){
        this.arr.push(value);
    }
    Dequeue(){
        return this.arr.shift();
    }
    IsEmpty(){
        if(this.arr.length===0){
            return true;
        }
        else
        return false;
    }
}

//example infile:
// 10 26
// 0 1
// 0 3
// 1 0
// 1 4
// 1 7
// 1 6
// 1 2
// 2 1
// 2 3
// 2 9
// 2 8
// 3 0
// 3 2
// 4 5
// 4 1
// 4 7
// 4 6
// 5 4
// 6 4
// 6 7
// 6 1
// 7 6
// 7 4
// 7 1
// 8 2
// 9 2


function breadth_first_number(graph, StartNode=0){
    var bfn=new Array(nodes);
    for(let i=0;i<nodes;i++){
        bfn[i]=0;
    }
    var order=1;
    bfn[StartNode]=order;
    visit[StartNode]=true;
    order++;
    var queue=new ArrayQueue();
    queue.Enqueue(StartNode);
    while(!queue.IsEmpty()){
        var current=queue.Dequeue();
        var connect=graph[current];
        var neighbor_index=[];
        var idx=connect.indexOf(1);
        while(idx!==-1){
            neighbor_index.push(idx);
            idx=connect.indexOf(1,idx+1);
        }
        //console.log(neighbor_index);
        for(let j=0;j<neighbor_index.length;j++){
            if(!visit[neighbor_index[j]]){
                bfn[neighbor_index[j]]=order;
                visit[neighbor_index[j]]=true;
                order++;
                queue.Enqueue(neighbor_index[j]);
            }
        }
    }
    return bfn;
}

var file:string=fs.readFileSync("infile.dat",'utf8','r+').split('\n');
var nodes=parseInt(file[0].split(' ')[0]);
var edges=parseInt(file[0].split(' ')[1]);

var graph=new Array(nodes);
for(let i=0;i<nodes;i++){
    graph[i]=new Array(nodes);
    for(let j=0;j<nodes;j++){
        graph[i][j]=-1;
    }
}
var edge_begin,edge_end;
for(let i=1;i<=edges;i++){
    edge_begin=parseInt(file[i].split(' ')[0]);
    edge_end=parseInt(file[i].split(' ')[1]);
    graph[edge_begin][edge_end]=1;
}
//console.log(graph);
var visit=new Array(nodes);
for(let i=0;i<nodes;i++){
    visit[i]=false;
}
var bfn=breadth_first_number(graph);
for(let j=0;j<nodes;j++){
    console.log(bfn.indexOf(Math.min.apply(null,bfn))+' '+Math.min.apply(null,bfn));
    bfn[bfn.indexOf(Math.min.apply(null,bfn))]=nodes+1;
}
