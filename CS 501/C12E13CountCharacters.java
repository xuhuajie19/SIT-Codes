//Count characters
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu

import javax.swing.*;
import java.util.Scanner;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

public class C12E13CountCharacters {

	public static List<String> readFile(String Filename)throws Exception {
		String line;
		List<String> res=new ArrayList<>();
		File file=new File(Filename);
		BufferedReader br = new BufferedReader(new FileReader(file));
		while((line=br.readLine())!=null){
			res.add(line);
		}
		br.close();
		return res;
    }

	public static void main(String[] args) {
		int flag = JOptionPane.YES_OPTION;
		JFileChooser fc = new JFileChooser();
		while (flag==0) {
			flag = JOptionPane.showConfirmDialog(null, "Open a file");
			if (flag==0) {
				fc.showOpenDialog(null);
				File f = fc.getSelectedFile();
				String location = f.getAbsolutePath();
				try {
					List<String> lines = readFile(location);

					int ln = lines.size();
					int wd = 0;
					int chr = 0;
					for (int i=0;i<ln;i++){
						wd += lines.get(i).split(" ").length;
						chr += lines.get(i).length();
					}
					flag = JOptionPane.showConfirmDialog(null, "The file has "+ln+" Lines, "+wd+" Words, "+chr+" Characters");
				}
				catch (Exception ex) {
					flag = JOptionPane.showConfirmDialog(null, "File not found.");
				}
			}
		}
	}
}