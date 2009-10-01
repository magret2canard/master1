package Forme;

import java.awt.geom.Point2D;


public interface Forme {

	public Point2D centreGravite();

	public void placer(Point2D nouveauCentreGravite);

	public void translater(double dx, double dy);
	
	public String toString();
}
