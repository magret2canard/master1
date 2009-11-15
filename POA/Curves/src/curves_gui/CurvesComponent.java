package curves_gui;

import java.awt.Color;
import java.awt.Graphics;

import javax.swing.JComponent;

public class CurvesComponent extends JComponent{
	private static final long serialVersionUID = 1L;

	public CurvesComponent(){
		super();

	}
	
	public void paint(Graphics g) {
	    g.setColor(Color.BLUE);
		g.draw3DRect(80,50,100,50,true);
		super.paint(g);
	}
}
