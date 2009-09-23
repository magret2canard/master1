package formes;

import java.awt.geom.*;


public abstract class FormesAbstraites implements Formes {
	protected Point2D centreGravite;

	
	public Point2D centreGravite() {
		return (Point2D) centreGravite.clone();
	}

	public void placer(Point2D nouveauCentreGravite) {
		centreGravite.setLocation(nouveauCentreGravite);
	}

	public void translater(double dx, double dy) {
		centreGravite.setLocation(centreGravite.getX() + dx, centreGravite
				.getY()
				+ dy);
	}
	
	public String toString(){
		return new String("-"+ centreGravite.toString());
	}
}
