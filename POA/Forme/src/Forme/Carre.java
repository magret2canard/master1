package Forme;

import java.awt.geom.Point2D;

public class Carre implements Forme {
	private Rectangle delegue;
	
	public Carre(Point2D p, double cote){
		delegue = new Rectangle(p, cote, cote);
	}
	
	public double cote(){
		return delegue.hauteur(); // idem with delegue.largeur();
	}
	
	public void changerCote(double nouveauCote){
		delegue.changerHauteur(nouveauCote);
		delegue.changerLargeur(nouveauCote);
	}
	
	public double perimetre() {
		return delegue.perimetre();
	}

	public double surface() {
		return delegue.surface();
	}
	
	public Point2D centreGravite() {
		return delegue.centreGravite();
	}

	public void placer(Point2D nouveauCentreGravite) {
		delegue.placer(nouveauCentreGravite);
	}

	public void translater(double dx, double dy) {
		delegue.translater(dx, dy);
	}
	
	public String toString(){
		return new String("Je suis un carre de centre "+delegue.centreGravite()+" et de côté "+cote()+".");
	}

}
