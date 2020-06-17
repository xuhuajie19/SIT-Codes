//area of a triangle
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu 01/30/2020
import java.util.*;

public class C2E19AreaOfATriangle {
	public static void main(String[] args){
		Scanner input = new Scanner(System.in);
		System.out.print("Enter the coordinates of three points separated by spaces like x1 y1 x2 y2 x3 y3: ");
		double x1 = input.nextDouble();
		double y1 = input.nextDouble();
		double x2 = input.nextDouble();
		double y2 = input.nextDouble();
		double x3 = input.nextDouble();
		double y3 = input.nextDouble();
		double d12 = Math.sqrt(Math.pow(x2-x1,2)+Math.pow(y2-y1,2));
		double d13 = Math.sqrt(Math.pow(x3-x1,2)+Math.pow(y3-y1,2));
		double d23 = Math.sqrt(Math.pow(x2-x3,2)+Math.pow(y2-y3,2));
		double s = (d12+d23+d13)/2;
		double result = Math.sqrt(s*(s-d12)*(s-d23)*(s-d13));
		System.out.println("The distance between the two points is "+result);
	}
}
