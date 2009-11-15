import javax.swing.SwingUtilities;

import curves_gui.*;

public class TestCurves {
	public static void main(String[] args){
		SwingUtilities.invokeLater(new Runnable(){
			public void run(){
				CurvesFrame fenetre = new CurvesFrame();
				fenetre.setVisible(true);
			}
		});
	}
}
