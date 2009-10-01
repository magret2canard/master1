package Forme;

import java.awt.geom.Point2D;

public  abstract class FormeAbstraite implements Forme{
	protected Point2D centreGravite;
	
	/* Intern class*/
	private class PointInterne extends Point2D{
		Point2D delegue;
		
		public PointInterne(Point2D p){
			delegue = (Point2D) p.clone();
		}
		
		public double getX(){
			return delegue.getX();
		}
		
		public double getY(){
			return delegue.getY();
		}
		
		public void setLocation(double x, double y){
			delegue.setLocation(x,y);
			System.out.println("Je me deplace en "+x+", "+y+".");
		}
		
		public String toString(){
			return new String("["+delegue.getX()+", "+delegue.getY()+"]");
		}
	}
	/* End Intern class */
	
	/* Private abstract constructor */
	protected FormeAbstraite(Point2D p){
		centreGravite = new PointInterne(p);	
	}
	
	public Point2D centreGravite() {
		return centreGravite;
	}

	public void placer(Point2D nouveauCentreGravite) {
		centreGravite.setLocation(nouveauCentreGravite);
	}

	public void translater(double dx, double dy) {
		centreGravite.setLocation(centreGravite.getX() + dx, 
								  centreGravite.getY() + dy);
	}
	
	public String toString(){
		return new String(centreGravite.toString());
	}
	
}
