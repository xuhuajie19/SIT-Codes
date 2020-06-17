//Display Images
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu 2020/5/5

import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.GridPane;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class C14E1DisplayImages extends Application {
	
	@Override
	public void start(Stage stage) throws Exception {
		GridPane pane = new GridPane();
		pane.setAlignment(Pos.TOP_LEFT);
		pane.setPadding(new Insets(1.5,2.5,3.5,4.5));
		pane.setHgap(5.5);
		pane.setVgap(5.5);

		Image image1 = new Image("/flag/uk.gif");
		ImageView imageView1=new ImageView(image1);
		pane.add(imageView1,0,0);
		imageView1.fitWidthProperty().bind(pane.widthProperty().divide(2));
		imageView1.fitHeightProperty().bind(pane.heightProperty().divide(2));

		Image image2 = new Image("/flag/ca.gif");
		ImageView imageView2=new ImageView(image2);
		pane.add(imageView2,1,0);
		imageView2.fitWidthProperty().bind(pane.widthProperty().divide(2));
		imageView2.fitHeightProperty().bind(pane.heightProperty().divide(2));

		Image image3 = new Image("/flag/china.gif");
		ImageView imageView3=new ImageView(image3);
		pane.add(imageView3,0,1);
		imageView3.fitWidthProperty().bind(pane.widthProperty().divide(2));
		imageView3.fitHeightProperty().bind(pane.heightProperty().divide(2));

		Image image4 = new Image("/flag/us.gif");
		ImageView imageView4=new ImageView(image4);
		pane.add(imageView4,1,1);
		imageView4.fitWidthProperty().bind(pane.widthProperty().divide(2));
		imageView4.fitHeightProperty().bind(pane.heightProperty().divide(2));

		Scene scene = new Scene(pane);
		stage.setTitle("Exercise14_01");
		stage.setScene(scene);
		stage.show();
	}
}