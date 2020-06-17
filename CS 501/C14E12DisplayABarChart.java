//Display a bar chart
//I pledge my honor that I have abided by the Stevens Honor System.
//Huajie Xu 2020/5/5

import java.awt.*;
import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.layout.BorderPane;
import javafx.scene.Scene;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class C14E12DisplayABarChart extends Application {
    @Override
    public void start(Stage stage) throws Exception {
        Rectangle r1=new Rectangle(10,40,50,40);
        r1.setStroke(Color.BLACK);
        r1.setFill(Color.RED);

        Rectangle r2=new Rectangle(70,52,50,52);
        r2.setStroke(Color.BLACK);
        r2.setFill(Color.BLUE);

        Rectangle r3=new Rectangle(130,56,50,56);
        r3.setStroke(Color.BLACK);
        r3.setFill(Color.GREEN);

        Rectangle r4=new Rectangle(190,52,50,52);
        r4.setStroke(Color.BLACK);
        r4.setFill(Color.ORANGE);

        Text t1=new Text(10,100,"Apple -- 20%");
        Text t2=new Text(70,90,"HTC -- 26%");
        Text t3=new Text(130,85,"Samsung -- 28%");
        Text t4=new Text(190,90,"Others -- 26%");

        Group group=new Group();
        group.getChildren().addAll(t1,r1,
                t2,r2,
                t3,r3,
                t4,r4);

        BorderPane pane=new BorderPane();

        r1.xProperty().bind(pane.widthProperty().multiply(0.04));
        r1.yProperty().bind(pane.heightProperty().multiply(0.8));
        r1.widthProperty().bind(pane.widthProperty().multiply(0.2));
        r1.heightProperty().bind(pane.heightProperty().multiply(0.2));

        r2.xProperty().bind(pane.widthProperty().multiply(0.28));
        r2.yProperty().bind(pane.heightProperty().multiply(0.74));
        r2.widthProperty().bind(pane.widthProperty().multiply(0.2));
        r2.heightProperty().bind(pane.heightProperty().multiply(0.26));

        r3.xProperty().bind(pane.widthProperty().multiply(0.52));
        r3.yProperty().bind(pane.heightProperty().multiply(0.72));
        r3.widthProperty().bind(pane.widthProperty().multiply(0.2));
        r3.heightProperty().bind(pane.heightProperty().multiply(0.28));

        r4.xProperty().bind(pane.widthProperty().multiply(0.76));
        r4.yProperty().bind(pane.heightProperty().multiply(0.74));
        r4.widthProperty().bind(pane.widthProperty().multiply(0.2));
        r4.heightProperty().bind(pane.heightProperty().multiply(0.26));

        t1.xProperty().bind(pane.widthProperty().multiply(0.04));
        t1.yProperty().bind(pane.heightProperty().multiply(0.78));

        t2.xProperty().bind(pane.widthProperty().multiply(0.28));
        t2.yProperty().bind(pane.heightProperty().multiply(0.72));

        t3.xProperty().bind(pane.widthProperty().multiply(0.52));
        t3.yProperty().bind(pane.heightProperty().multiply(0.7));

        t4.xProperty().bind(pane.widthProperty().multiply(0.76));
        t4.yProperty().bind(pane.heightProperty().multiply(0.72));

        pane.setBottom(group);
        Scene scene=new Scene(pane,250,150);

        stage.setTitle("Exercise14_12");
        stage.setScene(scene);
        stage.show();
    }
}
