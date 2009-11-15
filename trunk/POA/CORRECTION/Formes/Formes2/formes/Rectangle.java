package formes;

import java.awt.geom.*;

public class Rectangle extends FormeAbstraite {
	private double hauteur;

	private double largeur;

	public Rectangle(Point2D p, double hauteur, double largeur) {
		super(p);
		this.hauteur = hauteur;
		this.largeur = largeur;
	}

	public double perimetre() {
		return 2. * (hauteur + largeur);
	}

	public double surface() {
		return hauteur * largeur;
	}

	public double hauteur() {
		return hauteur;
	}

	public double largeur() {
		return largeur;
	}

	public void changerHauteur(double nouvelleHauteur) {
		hauteur = nouvelleHauteur;
	}

	public void changerLargeur(double nouvelleLargeur) {
		largeur = nouvelleLargeur;
	}

	public String toString() {
		return super.toString() + " de hauteur " + hauteur + " et largeur "
				+ largeur;
	}

}
