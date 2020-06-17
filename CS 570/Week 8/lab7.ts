const readline=require('readline');
const readlines=require('readline-sync');

class MaxHeap{
    arr=[null];

    insertHeap(data){
        this.arr.push(data);
        var idx=this.arr.length-1;
        if((Math.floor(idx))===1){
            return;
        }
        while((Math.floor(idx/2))>=1){
            if(this.arr[(Math.floor(idx/2))]<this.arr[idx]){
                [this.arr[(Math.floor(idx/2))],this.arr[idx]]=[this.arr[idx],this.arr[(Math.floor(idx/2))]];
            }
            idx=Math.floor(idx/2);
        }
    }

    remove(){
        if(this.arr.length===1){
            return null;
        }
        else if(this.arr.length===2){
            var number=this.arr.splice(1,1);
            return number[0];
        }
        else{
            var max=this.arr[1];
            this.arr[1]=this.arr[this.arr.length-1];
            this.arr.splice(this.arr.length-1,1);
            let idx=1;
            while(true){
                if((this.arr[2*idx]===undefined)&&(this.arr[2*idx+1]===undefined)){
                    return max;
                }
                else if(this.arr[2*idx+1]===undefined){
                    if(this.arr[idx]<this.arr[2*idx]){
                        [this.arr[idx],this.arr[2*idx]]=[this.arr[2*idx],this.arr[idx]];
                    }
                    return max;
                }
                else{
                    if(this.arr[idx]<Math.max(this.arr[2*idx],this.arr[2*idx+1])){
                        if(this.arr[2*idx]>this.arr[2*idx+1]){
                            [this.arr[idx],this.arr[2*idx]]=[this.arr[2*idx],this.arr[idx]];
                            idx=idx*2;
                        }
                        else{
                            [this.arr[idx],this.arr[2*idx+1]]=[this.arr[2*idx+1],this.arr[idx]];
                            idx=idx*2+1;
                        }
                    }
                    else{
                        return max;
                    }
                }
            }
        }
    }
}

var maxheap=new MaxHeap();
var count=0;
while(count<10){
    var value=readlines.questionInt('Please input the number you want to insert to the maxheap: ');
    maxheap.insertHeap(value);
    count++;
}
var result=[];
for(let i=0;i<10;i++){
    result.push(maxheap.remove());
}
console.log('Output the numbers in descending order: ',result);