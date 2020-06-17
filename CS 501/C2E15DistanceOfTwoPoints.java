//distance of two points
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu 01/30/2020
import java.util.*;

public class C2E15DistanceOfTwoPoints {
	public static void main(String[] args){
		Scanner input = new Scanner(System.in);
		System.out.print("Enter x1 and y1: ");
		double x1 = input.nextDouble();
		double y1 = input.nextDouble();
		System.out.print("Enter x2 and y2: ");
		double x2 = input.nextDouble();
		double y2 = input.nextDouble();
		double result = Math.sqrt(Math.pow(x2-x1,2)+Math.pow(y2-y1,2));
		System.out.print("The distance between the two points is "+result);
	}
}
