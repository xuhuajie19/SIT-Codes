const fs = require('fs');
const path = require('path');
var digraph: number[][];
var nodes, edges;
var ingraph: boolean[];

function indegree(y:number):number{
	var temp = 0;
	for (var i=0;i<nodes;i++) {
		if ((digraph[i][y] == 1)&&(ingraph[i])) {
			temp += 1;
		}
	}
	return temp;
}

function printlist(x:number):void{
	var output="The topological sort result "+x.toString()+" is: "
	for (i=1;i<=nodes;i++)
		output += id[i].toString()+' ';
	console.log(output);
	return;
}

// example infile:
// 4 5
// 0 2
// 0 3
// 1 2
// 1 3
// 2 3
try {
	var file: string = fs.readFileSync("infile.dat",'utf8','r+').split('\n');	
}
catch (e){
	console.log('File not exist');
	process.exit(0);
}

nodes = parseInt(file[0].split(' ')[0]);
edges = parseInt(file[0].split(' ')[1]);

for (var i=0;i<nodes;i++) {
	for (var j=0;j<nodes;j++){
		if (!digraph){
			digraph = [];
		}
		if (!digraph[i]){
			digraph[i] = [];
		}
		digraph[i][j] = -1;
	}
	if (!ingraph)
		ingraph = [];
	ingraph[i] = true;
}

var edge_end_node_1, edge_end_node_2;

//line 1-edges: edges
for (i=1;i<=edges;i++) {
	edge_end_node_1 = parseInt(file[i].split(' ')[0]);
	edge_end_node_2 = parseInt(file[i].split(' ')[1]);
	digraph[edge_end_node_1][edge_end_node_2] = 1;
}

var id: number[];
var i = 0;
while (i<nodes) {
	var u = -1;
	for (var j=0;j<nodes;j++) {
		if ((indegree(j)==0)&&(ingraph[j])) {
			u = j;
			break;
		}
	}
	if (u == -1) {
		console.log("D is not acyclic");
		process.exit(0);
	}
	i += 1;
	if (!id) {
		id = [];
	}
	id[i] = u;
	ingraph[u] = false;
}

printlist(1);

//Round 2, clear the list and restore the status
for (var i=0;i<nodes;i++) {
	ingraph[i] = true;
	id[i+1] = 0;
}

i = 0;
while (i<nodes) {
	var u = -1;
	for (var j=nodes-1;j>=0;j--) {
		if ((indegree(j)==0)&&(ingraph[j])) {
			u = j;
			break;
		}
	}
	if (u == -1) {
		console.log("D is not acyclic");
		process.exit(0);
	}
	i += 1;
	if (!id) {
		id = [];
	}
	id[i] = u;
	ingraph[u] = false;
}
printlist(2);