package formes;

import java.awt.geom.*;

public class TestFormes {

	public static void main(String[] args){
		Point2D p = new Point2D.Double(5.0, 6.0);
		Point2D p2 = new Point2D.Double(6.0, 7.0);
		Cercle unCercle = new Cercle(p, 4.0);
		
		Rectangle unRectangle = new Rectangle(p2, 7.0, 8.0);
		
		Carre unCarre = new Carre(p, 3.0);
		
		System.out.println("Centre du carre "+unCarre);
		System.out.println("Centre du rectangle "+unRectangle.centreGravite());
		
		unCercle.translater(2.0, 2.0);
		unRectangle.translater(2.0, 2.0);
		
		System.out.println("Centre du cercle "+unCercle.centreGravite());
		System.out.println("Centre du rectangle "+unRectangle.centreGravite());
	}
}
