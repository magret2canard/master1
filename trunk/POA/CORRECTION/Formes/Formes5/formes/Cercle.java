package formes;

import java.awt.geom.*;

public class Cercle extends FormeAbstraite {
	private double rayon;

	public Cercle(Point2D p, double rayon) {
		super(p);
		this.rayon = rayon;
	}

	public double perimetre() {
		return 2 * Math.PI * rayon;
	}

	public double surface() {
		return Math.PI * rayon * rayon;
	}

	public double rayon() {
		return rayon;
	}

	public void changerRayon(double nouveauRayon) {
		rayon = nouveauRayon;
	}
		
	public String toString() {
		return super.toString() + " et de rayon " + rayon;
	}
}
