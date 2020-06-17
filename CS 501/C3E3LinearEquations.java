//linear equations
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu 02/14/2020
import java.util.*;

public class C3E3LinearEquations {
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		System.out.println("Enter a, b, c, d, e, f");
		double a = input.nextDouble();
		double b = input.nextDouble();
		double c = input.nextDouble();
		double d = input.nextDouble();
		double e = input.nextDouble();
		double f = input.nextDouble();
		if (a*d-b*c == 0) {
			System.out.println("The equation has no solution");
		}
		else {
			double x = (d*e-b*f) / (a*d-b*c);
			double y = (a*f-c*e) / (a*d-b*c);
			System.out.println("x is "+x+" and y is "+y);
		}
	}
}