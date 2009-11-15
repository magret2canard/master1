package formes;

import java.awt.geom.*;

public class Carre implements Forme {

	private Rectangle delegue;

	public Carre(Point2D p, double cote) {
		delegue = new Rectangle(p, cote, cote);
	}

	public double perimetre() {
		return delegue.perimetre();
	}

	public double surface() {
		return delegue.surface();
	}

	public void changerCote(double nouvelleTaille) {
		delegue.changerHauteur(nouvelleTaille);
		delegue.changerLargeur(nouvelleTaille);
	}

	public String toString() {
		return this.getClass().getName() + " de centre ("
		+ delegue.centreGravite.getX() + "," + delegue.centreGravite.getY() + ")" +
 " de taille " + delegue.hauteur();
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
}
