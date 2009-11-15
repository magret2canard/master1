

import java.awt.Color;
import java.awt.geom.Point2D;

import formes.Carre;
import formes.Cercle;
import formes.Forme;
import formes.FormeColoreeDefaut;
import formes.Formes;
import formes.Rectangle;

public class TestFormes {
	public static void main(String args[]) {
		Rectangle r = new Rectangle(new Point2D.Double(Double.parseDouble(args[0]), Double
				.parseDouble(args[1])), Double.parseDouble(args[2]), Double
				.parseDouble(args[3]));
		Cercle c = new Cercle(new Point2D.Double(Double.parseDouble(args[4]), Double
				.parseDouble(args[5])), Double.parseDouble(args[6]));
		System.out.println(r.surface());
		System.out.println(c.perimetre());
		Carre ca = new Carre(new Point2D.Double(Double.parseDouble(args[7]), Double
				.parseDouble(args[8])), Double.parseDouble(args[9]));
		System.out.println(r.surface());
		System.out.println(c.perimetre());
		System.out.println(ca.perimetre());
				
		Formes.afficher(r);
		Formes.afficher(c);		
		Forme cac = new FormeColoreeDefaut(ca, Color.red, Color.blue);
		Formes.afficher(cac);
		
		ca.placer(new Point2D.Double(10,10));
		Point2D p = ca.centreGravite();
		p.setLocation(20, 20);
	}
}
