package Forme;

import java.awt.Color;
import java.awt.geom.Point2D;

public class FormeColoreeImpl implements FormeColoree{
	private Color fond;
	private Color encre;
	private Forme forme;
	
	public FormeColoreeImpl(Forme forme, Color fond, Color encre){
		this.forme =  forme;
		this.fond = fond;
		this.encre = encre;
	}
	
	public Color couleurFond(){
		return fond;
	}
	
	public Color couleurEncre(){
		return encre;
	}
	
	public Forme forme(){
		return forme;
	}
	
	public Point2D centreGravite() {
		return forme.centreGravite();
	}

	public void placer(Point2D nouveauCentreGravite) {
		forme.placer(nouveauCentreGravite);
	}

	public void translater(double dx, double dy) {
		forme.translater(dx, dy);
	}
	
	public String toString(){
		return new String(forme.toString() + " Je suis colorée d'encre "+encre+" et de fond "+fond+".");
	}
}
