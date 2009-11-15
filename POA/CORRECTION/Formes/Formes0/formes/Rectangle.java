package formes;

import java.awt.geom.*;

public class Rectangle {
	private double hauteur;

	private double largeur;

	private Point2D centreGravite;

	public Rectangle(Point2D p, double hauteur, double largeur) {
		centreGravite = (Point2D) p.clone();
		this.hauteur = hauteur;
		this.largeur = largeur;
	}

	public double perimetre() {
		return 2. * (hauteur + largeur);
	}

	public double surface() {
		return hauteur * largeur;
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

	public void changerHauteur(double nouvelleHauteur) {
		hauteur = nouvelleHauteur;
	}

	public void changerLargeur(double nouvelleLargeur) {
		largeur = nouvelleLargeur;
	}
}
