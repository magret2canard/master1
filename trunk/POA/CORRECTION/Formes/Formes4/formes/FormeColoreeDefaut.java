package formes;

import java.awt.Color;
import java.awt.geom.Point2D;

public class FormeColoreeDefaut implements FormeColoree {

	private Color fond;

	private Color encre;

	private Forme delegue;

	public FormeColoreeDefaut(Forme f, Color fond, Color encre) {
		this.delegue = f;
		this.fond = fond;
		this.encre = encre;
	}

	public void changerCouleurEncre(Color nouvelleCouleur) {
		encre = nouvelleCouleur;
	}

	public void changerCouleurFond(Color nouvelleCouleur) {
		fond = nouvelleCouleur;
	}

	public Color couleurEncre() {
		return encre;
	}

	public Color couleurFond() {
		return fond;
	}

	public Point2D centreGravite() {
		return delegue.centreGravite();
	}

	public double perimetre() {
		return delegue.perimetre();
	}

	public void placer(Point2D nouveauCentreGravite) {
		delegue.placer(nouveauCentreGravite);
	}

	public double surface() {
		return delegue.surface();
	}

	public void translater(double dx, double dy) {
		delegue.translater(dx, dy);
	}

	public String toString() {
		return delegue.toString() + " d'encre " + encre + " et de fond " + fond;
	}
}
