//estimate areas
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu 02/14/2020
import java.util.*;

public class C4E3EstimateAreas {
	public static void main(String[] args){
		Scanner input=new Scanner(System.in);
		double radius = 6371.01;
		double x1 = Math.toRadians(35.2270869);
		double y1 = Math.toRadians(-80.8431267);
		double x2 = Math.toRadians(32.0835407);
		double y2 = Math.toRadians(-81.0998342);
		double x3 = Math.toRadians(28.5383355);
		double y3 = Math.toRadians(-81.3792365);
		double x4 = Math.toRadians(33.7489954);
		double y4 = Math.toRadians(-84.3879824);
		double d12 = radius * Math.acos(Math.sin(x1)*Math.sin(x2) + Math.cos(x1)*Math.cos(x2)*Math.cos(y1-y2));
		double d23 = radius * Math.acos(Math.sin(x3)*Math.sin(x2) + Math.cos(x3)*Math.cos(x2)*Math.cos(y3-y2));
		double d13 = radius * Math.acos(Math.sin(x1)*Math.sin(x3) + Math.cos(x1)*Math.cos(x3)*Math.cos(y1-y3));
		double s = (d12+d23+d13)/2;
		double s1 = Math.sqrt(s*(s-d12)*(s-d23)*(s-d13));
		double d34 = radius * Math.acos(Math.sin(x3)*Math.sin(x4) + Math.cos(x3)*Math.cos(x4)*Math.cos(y3-y4));
		double d14 = radius * Math.acos(Math.sin(x1)*Math.sin(x4) + Math.cos(x1)*Math.cos(x4)*Math.cos(y1-y4));
		s = (d13+d34+d14)/2;
		double s2 = Math.sqrt(s*(s-d13)*(s-d34)*(s-d14));
		System.out.println("The estimated area enclosed by these four cities is: "+(s1+s2)+ " km^2");
	}
}