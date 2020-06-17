const readline=require('readline-sync');
var len;
var array=[];
len=readline.question("What is the length of array?");
for(let i=0;i<len;i++){
    array[i]=Math.ceil((Math.random()*240)+10);
}
console.log("The random array is: ",array);
var new_array=Bubble_sort(array);
console.log("After the bouncing bubble sort, the new array is: ",new_array);

function Bubble_sort(arr){
    var first=0;
    var last=arr.length-1;
    while (first<last) {
        for(let i=first;i<last;i++){
            if(arr[i]>arr[i+1]){
                let temp=arr[i];
                arr[i]=arr[i+1];
                arr[i+1]=temp;
            }
        }
        last--;

        for(let j=last;j>first;j--){
            if(arr[j]<arr[j-1]){
                let temp=arr[j];
                arr[j]=arr[j-1];
                arr[j-1]=temp;
            }
        }
        first++;
    }
    return arr;
}