package formes;

import java.awt.geom.*;

public class Cercle {
	private double rayon;

	private Point2D centreGravite;

	public Cercle(Point2D p, double rayon) {
		centreGravite = (Point2D) p.clone();
		this.rayon = rayon;
	}

	public double perimetre() {
		return 2 * Math.PI * rayon;
	}

	public double surface() {
		return Math.PI * rayon * rayon;
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

	public void changerRayon(double nouveauRayon) {
		rayon = nouveauRayon;
	}
}
