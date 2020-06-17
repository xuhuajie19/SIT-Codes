//great circle distance
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu 02/14/2020
import java.util.*;

public class C4E2GreatCircleDistance {
	public static void main(String[] args) {
		double radius = 6371.01;
		System.out.println("Enter point 1 (latitude and longitude) in degrees: ");
		Scanner input = new Scanner(System.in);
		double x1 = Math.toRadians(input.nextDouble());
		double y1 = Math.toRadians(input.nextDouble());
		System.out.println("Enter point 2 (latitude and longitude) in degrees: ");
		double x2 = Math.toRadians(input.nextDouble());
		double y2 = Math.toRadians(input.nextDouble());
		double d = radius * Math.acos(Math.sin(x1)*Math.sin(x2) + Math.cos(x1)*Math.cos(x2)*Math.cos(y1-y2));
		System.out.println("The distance between the two points is "+d+" km");
	}
}