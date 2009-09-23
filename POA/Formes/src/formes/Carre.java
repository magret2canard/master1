package formes;

import java.awt.geom.*;

public class Carre extends FormesAbstraites{
	private Rectangle rectangle;
	
	public Carre(Point2D p, double cote){
		rectangle = new Rectangle(p, cote, cote);
	}
	
	public double hauteur(){
		return rectangle.hauteur();
	}
	
	public double largeur(){
		return rectangle.largeur();
	}
	
	public double perimetre() {
		return 2. * this.hauteur();
	}

	public double surface() {
		return this.hauteur() * this.largeur();
	}

	public String toString(){
		return new String("carre");
	}
}