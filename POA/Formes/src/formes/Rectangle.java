package formes;

import java.awt.geom.*;

public class Rectangle extends FormesAbstraites{
	private double hauteur;
	private double largeur;


	public Rectangle(Point2D p, double hauteur, double largeur) {
		centreGravite = (Point2D) p.clone();
		this.hauteur = hauteur;
		this.largeur = largeur;
	}

	public double hauteur(){
		return this.hauteur;
	}
	
	public double largeur(){
		return this.largeur;
	}
	
	public double perimetre() {
		return 2. * (hauteur + largeur);
	}

	public double surface() {
		return hauteur * largeur;
	}


	public void changerHauteur(double nouvelleHauteur) {
		this.hauteur = nouvelleHauteur;
	}

	public void changerLargeur(double nouvelleLargeur) {
		this.largeur = nouvelleLargeur;
	}
	
	public String toString(){
		return new String("rectangle");
	}
}
