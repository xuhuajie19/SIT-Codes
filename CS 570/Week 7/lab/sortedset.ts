var readline = require('readline');
var readlinesync = require('readline-sync');
var path = require('path');
var fs = require('fs');

//https://www.youtube.com/watch?v=5cU1ILGy6dM&t=65s
class BNode {
	data: number;
	left: BNode; 
	right: BNode;
	constructor(data, left = null, right = null) {
		this.data = data;
		this.left = left;
		this.right = right;
	}
}

class SortedSet {
	root: BNode;
	isEmpty() {
		if (this.root==null) {
			return true;
		}
		else {
			return false;
		}
	}
	add(data) {
		const addNode = function(node, data){
			// the tree is empty
			if (node === null) {
				node = new BNode(data);
				return;
			}
			// search left
			if (data<node.data) {
				if (node.left === null) {
					node.left = new BNode(data);
					return;
				}
				else
					addNode(node.left,data);
			}
			// search right
			if (data>node.data) {
				if (node.right === null) {
					node.right = new BNode(data);
					return;
				}
				else
					addNode(node.right,data);
			}
		}
		addNode(this.root, data);
	}
	remove(data) {
		const removeNode = function(node, data) {
			if (node == null) {
				return null;
			}
			if (data == node.data) {
				// node has no children 
				if (node.left == null && node.right == null) {
					return null;
				}
				// node has no left child 
				if (node.left == null) {
					return node.right;
				}
				// node has no right child 
				if (node.right == null) {
					return node.left;
				}
				// node has two children 
				var tempNode = node.right;
				while (tempNode.left !== null) {
					tempNode = tempNode.left;
				}
				node.data = tempNode.data;
				node.right = removeNode(node.right, tempNode.data);
				return node;
			} else if (data < node.data) {
				node.left = removeNode(node.left, data);
				return node;
			} else {
				node.right = removeNode(node.right, data);
				return node;
			}
		}
		this.root = removeNode(this.root, data);
	}

	contains(data) {
		let current = this.root;
		while (current) {
			if (data == current.data) {
				return "Yes";
			}
			if (data < current.data) {
				current = current.left;
			} else {
				current = current.right;
			}
		}
		return "No";
	}
	constructor(initData) {
		// https://www.geeksforgeeks.org/javascript-string-prototype-split-function/
		var rawset = initData.split(", ");
		// create root
		this.root = new BNode(rawset[0]);
		// insert other elements
		for (var i=1;i<rawset.length;i++)
			this.add(parseInt(rawset[i]));
	}
}

var file: string = fs.readFileSync('infile.dat','utf8','r+');
const bst = new SortedSet(file);
let target = readlinesync.questionInt('Please input the value you want to find: ');
console.log(bst.contains(target));