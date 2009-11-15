package curves;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;

import javax.swing.JComponent;

/**
 * 
 * @author casteran
 * 
 */

class CurveTracer extends JComponent {
	private static final long serialVersionUID = 1L;
	
	FunctionVariations fvar;
	
	private static final double croppingFactor = 0.9;
	
	CurveTracer(FunctionVariations var) {
		this.fvar = var;
		setPreferredSize(new Dimension(400, 300));
		setOpaque(true);
		setBackground(Color.green);
		setForeground(Color.red);
	}
	
	protected int getY(double y){
		int h = getHeight();
		if(fvar.isConstant())
			return (int)h/2;
		else{
			double ymax = fvar.getYmax();
			return (int)((h * (1- croppingFactor)/2.0) + h*croppingFactor * (y-ymax)/(fvar.getYmin() -ymax));
		}
	}
	
	protected void paintComponent(Graphics g) {
		int width = getWidth();
		// Paint background if we're opaque.
		if (isOpaque()) {
			g.setColor(getBackground());
			g.fillRect(0, 0, width, getHeight());
		}

		g.setColor(getForeground());
		fvar.tabulate(20);
		//System.out.println(fvar.getStepValue(0));
		
		g.drawLine(0, getY(fvar.getStepValue(0)), 20, getY(fvar.getStepValue(17)) );
		//g.drawLine(200, getY(fvar.getStepValue(200)), 400, getY(fvar.getStepValue(400)));
		//g.drawLine(200, getY(200), 300, getY(300));
		//g.drawLine(300, getY(300), 400, getY(400));
		//g.drawLine(400, getY(400), 500, getY(500));	
		
	}
	
		
	
	
}
