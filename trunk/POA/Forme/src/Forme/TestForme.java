package Forme;

import java.awt.geom.Point2D;
import java.awt.Color;


public class TestForme {

	public static void main(String[] args){
		Point2D p1 = new Point2D.Double(5.0, 6.0);
		Point2D p2 = new Point2D.Double(6.0, 7.0);
		
		/* ----------------------------------- Circle test ----------------------------------- */	
		System.out.println("Test du Cercle :");
		
		Cercle unCercle = new Cercle(p1, 4.0);
		
		System.out.println(unCercle);
		System.out.println("Mon perimètre est de "+unCercle.perimetre()+" et ma surface est de "+unCercle.surface()+".");
		
		unCercle.placer(p2);
		unCercle.translater(7.0, 8.0);
		
		unCercle.changerRayon(5.0);
		System.out.println(unCercle);
		
		
		/* ----------------------------------- Rectangle test -----------------------------------*/
		System.out.println();
		System.out.println("Test du Rectangle :");
		
		double hauteur = 4.0;
		double largeur = 6.0;
		
		Rectangle unRectangle = new Rectangle(p1, hauteur, largeur);
		
		System.out.println(unRectangle);
		unRectangle.placer(p2);
		unRectangle.translater(7.0, 0);
		
		System.out.println("Mon perimètre est de "+unRectangle.perimetre()+" et ma surface est de "+unRectangle.surface()+".");
		
		unRectangle.changerHauteur(8);
		unRectangle.changerLargeur(10);
		System.out.println(unRectangle);
		
		/* ----------------------------------- Carre test -----------------------------------*/
		System.out.println();
		System.out.println("Test du Carre :");
		
		double cote = 5.0;
		
		Carre unCarre = new Carre(p1, cote);
		
		System.out.println(unCarre);
		unCarre.placer(p2);
		unCarre.translater(0, 8.0);
		
		System.out.println("Mon perimètre est de "+unCarre.perimetre()+" et ma surface est de "+unCarre.surface()+".");
		
		unCarre.changerCote(7.0);	
		System.out.println("Mon perimètre est de "+unCarre.perimetre()+" et ma surface est de "+unCarre.surface()+".");
		
		/* ----------------------------------- FormeColoree test ----------------------------------- */
		System.out.println();
		System.out.println("Test d'une Forme Coloree (carre) :");
		
		Color fond = Color.ORANGE;
		Color encre = Color.BLACK;
		
		FormeColoree unCarreColoree = new FormeColoreeImpl(unCarre, fond, encre);
		System.out.println(unCarreColoree);
		
		unCarreColoree.placer(p1);
		unCarreColoree.translater(0, 8.0);
		
		//...
		/*
		ArrayList<Integer> tab = new ArrayList();
		
		tab.add(4);
		tab.add(5);
		tab.add(6);
		
		Iterator i = (Iterator) tab.iterator();
		
		while(i.hasNext()){
			int a = (int)i.next();
			System.out.println(a);
		}
		*/
	}
}
