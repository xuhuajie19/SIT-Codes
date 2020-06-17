//points in triangle
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu 02/14/2020
import java.util.*;
public class C3E27PointsInTriangle {
	public static void main(String[] args) {
		Scanner input=new Scanner(System.in);
		System.out.println("Enter a point’s x- and y-coordinates:");
		double x = input.nextDouble();
		double y = input.nextDouble();
		boolean w = true;
		//The diagonal is y=-0.5x+100(0<=x<=200)
		if ((x<0) || (x>200)) {
			w = false;
		}
		else {
			if ((y>-0.5*x+100) || (y<0)) {
				w = false;
			}
		}

		if (w == true) {
			System.out.println("The point is in the triangle");
		}
		else {
			System.out.println("The point is not in the triangle");
		}
	}
}