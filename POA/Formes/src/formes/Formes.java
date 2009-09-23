package formes;

import java.awt.geom.*;


public interface Formes {

	
	public Point2D centreGravite();

	public void placer(Point2D nouveauCentreGravite);

	public void translater(double dx, double dy);
	
	public String toString();
}