package Forme;

import java.awt.geom.Point2D;


public class Cercle extends FormeAbstraite{
	double rayon;
	
	public Cercle(Point2D p, double rayon){
		super(p);
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
	
	public String toString(){
		return new String("Je suis un cercle de centre "+super.toString()+ " et de rayon "+rayon+".");
	}


}
