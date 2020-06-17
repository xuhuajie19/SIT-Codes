//check password
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu
import java.util.*;
import javax.swing.*;

public class C6E18CheckPassword {
	public static void main(String[] args){
		int flag = JOptionPane.YES_OPTION;
		while (flag == JOptionPane.YES_OPTION) {
			try {
				String str = JOptionPane.showInputDialog("Please input a password that: \n"+
					"A password must have at least ten characters.\n"+
					"A password consists of only letters and digits.\n"+
					"A password must contain at least three digits.\n"
					);

				int len = str.length();
				if (len<10) {
					Exception e = new Exception("A password must have at least ten characters.");
					throw e;
				}

				int cletter = 0;
				int cdigit = 0;
				for (int i=0;i<len;i++) {
					char temp = str.charAt(i);
					if (Character.isDigit(temp)) {
						cdigit++;
					}
					if (Character.isLetter(temp)) {
						cletter++;
					}
				}
				if (cletter+cdigit < len) {
					Exception e = new Exception("A password consists of only letters and digits.");
					throw e;
				}
				if (cdigit < 3) {
					Exception e = new Exception("A password must contain at least three digits.");
					throw e;
				}

				flag = JOptionPane.showConfirmDialog(null,"Valid Password");
			}
			catch (Exception ex) {
				flag = JOptionPane.showConfirmDialog(null,"Invalid Password");
			}
		}
	}
}