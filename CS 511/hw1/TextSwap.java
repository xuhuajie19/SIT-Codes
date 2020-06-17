import java.io.*;
import java.util.*;

public class TextSwap {

    private static String readFile(String filename) throws Exception {
        String line;
        StringBuilder buffer = new StringBuilder();
        File file = new File(filename);
        BufferedReader br = new BufferedReader(new FileReader(file));
        while ((line = br.readLine()) != null) {
            buffer.append(line);
        }
        br.close();
        return buffer.toString();
    }

    private static Interval[] getIntervals(int numChunks, int chunkSize) {
        Interval[] a=new Interval[numChunks];
        for(int i=0;i<numChunks;i++){
            Interval temp=new Interval(chunkSize*i,chunkSize*(i+1)-1);
            a[i]=temp;
        }
        return a;
    }

    private static List<Character> getLabels(int numChunks) {
        Scanner scanner = new Scanner(System.in);
        List<Character> labels = new ArrayList<Character>();
        int endChar = numChunks == 0 ? 'a' : 'a' + numChunks - 1;
        System.out.printf("Input %d character(s) (\'%c\' - \'%c\') for the pattern.\n", numChunks, 'a', endChar);
        for (int i = 0; i < numChunks; i++) {
            labels.add(scanner.next().charAt(0));
        }
        scanner.close();
        // System.out.println(labels);
        return labels;
    }

    private static char[] runSwapper(String content, int chunkSize, int numChunks) {
        List<Character> labels = getLabels(numChunks);
        Interval[] intervals = getIntervals(numChunks, chunkSize);

        HashMap<Integer,Integer> hashmap=new HashMap<>();
        for(int i=0;i<labels.size();i++){
            char x=labels.get(i);
            hashmap.put(x-97,i);
        }

        char[] buff=new char[content.length()];
        Thread[] threads=new Thread[numChunks];

        for(int i=0;i<numChunks;i++){
            threads[i]=new Thread(new Swapper(intervals[i],content,buff,hashmap.get(i)*chunkSize));
        }

        for(int i=0;i<numChunks;i++){
            threads[i].start();
        }

        try{
            for(int i=0;i<numChunks;i++){
                threads[i].join();
            }
        }catch (InterruptedException e){
            e.printStackTrace();
        }
        
        return buff;
    }

    private static void writeToFile(String contents, int chunkSize, int numChunks) throws Exception {
        char[] buff = runSwapper(contents, chunkSize, contents.length() / chunkSize);
        PrintWriter writer = new PrintWriter("output.txt", "UTF-8");
        writer.print(buff);
        writer.close();
    }

    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Usage: java TextSwap <chunk size> <filename>");
            return;
        }
        String contents = "";
        int chunkSize = Integer.parseInt(args[0]);
        try {
            contents = readFile(args[1]);
            writeToFile(contents, chunkSize, contents.length() / chunkSize);
        } catch (Exception e) {
            System.out.println("Error with IO.");
            return;
        }
    }
}