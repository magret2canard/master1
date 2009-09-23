package formes;

import java.awt.geom.*;

public class Cercle extends FormesAbstraites{
	double rayon;
	
	public Cercle(Point2D p, double rayon){
		centreGravite = (Point2D) p.clone();
		this.rayon = rayon;
	}
	
	public double perimetre() {
		return 2. * Math.PI * rayon;
	}

	public double surface() {
		return Math.PI * rayon * rayon;
	}


	public void changerRayon(double nouveauRayon) {
		this.rayon = nouveauRayon;
	}


}
