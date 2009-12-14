package formes;

import java.awt.geom.*;

public abstract class FormeAbstraite {

	private Point2D centreGravite;

	public FormeAbstraite(Point2D p) {
		centreGravite = (Point2D) p.clone();
	}

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
}