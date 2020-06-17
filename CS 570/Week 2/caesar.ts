// npm install --save @types/node readfile_sync
const readline=require('readline-sync');
const fs = require('fs');
const path = require('path');

function decrypt(asc,i){
	//if letter
	if (((asc>=65)&&(asc<=90))||((asc>=97)&&(asc<=122))){
		var LETTER0 = asc % 32;// A1B2C3D4 a1b2c3d4, gcd(64,96)=32
		var newkey = key+i*2;
		var LETTER1 = (LETTER0-newkey) % 26;
		// 1<=LETTER1<=26
		while (LETTER1 <= 0) {
			LETTER1 += 26;
		};

		return String.fromCharCode(asc-LETTER0+LETTER1);
	}
	//not letter
	else{
		return String.fromCharCode(asc);
	}
}

var fname = '';
do{
	try{
		fname = readline.question('What is the file name?');
		var file: string = fs.readFileSync(fname,'utf8','r+');
	} 
	// An exception would be raised if the file didn't exist, then ask the user to try again.
	catch (e){
		console.log('Try again');
		fname = '';
	}
} while (!fname);

const len = file.length-1;
const key = 5;
//http://dilegencehe.blog.163.com/blog/static/43255413201111178523181/

var section = Math.ceil(len / 3);
var solution = '';

for (var i=0;i<=section-1;i++){
	for (var j=0;j<3;j++){
		if (i*3+j<=len){
			var asc = file[i*3+j].charCodeAt(0);
			solution += decrypt(asc,i);
		}
	}
		
}

fs.writeFileSync('solution.txt',solution,{encoding: 'utf8'});