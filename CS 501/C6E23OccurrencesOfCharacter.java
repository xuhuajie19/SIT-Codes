//Occurrences of character
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu

import javax.swing.*;
import java.util.Scanner;
import java.awt.Font;

public class C6E23OccurrencesOfCharacter {
	public static int count(String str, char a) {
		int len = str.length();
		int count = 0;
		for (int i=0;i<len;i++) {
			if (a == str.charAt(i)) {
				count++;
			}
		}
		return count;
	}

	public static void main(String[] args){
		Scanner input=new Scanner(System.in);
		System.out.println("Please input a string or press /QUIT to exit");
		String str = input.next();
		if (str == "/QUIT") {
			System.exit(0);
		}
		else {
			try {
				int len = str.length();
				for (int i=0;i<len;i++) {
					if ((str.charAt(i)<32)||(str.charAt(i)>=128)) {
						Exception e = new Exception("The string must contain only printable char.");
						throw e;
					}
				}

				String chars = input.next();
				int lenc = chars.length();
				for (int i=0;i<lenc;i++) {
					char tosearch = chars.charAt(i);
					System.out.println("Char "+tosearch+" occurred "+count(str,tosearch)+" times.");
				}

			}
			catch (Exception ex) {
				int flag = JOptionPane.showConfirmDialog(null,"Invalid String");
			}
		}


		}
}