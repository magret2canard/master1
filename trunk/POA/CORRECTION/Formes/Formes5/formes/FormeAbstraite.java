package formes;

import java.awt.geom.*;

public abstract class FormeAbstraite implements Forme {

	private class PointCentre extends Point2D {
		Point2D delegue;

		PointCentre(Point2D p) {
			delegue = (Point2D) p.clone();
		}
		
		public Object clone() {
			return delegue.clone();
		}

		public double getX() {
			return delegue.getX();
		}

		public double getY() {
			return delegue.getY();
		}

		public void setLocation(double x, double y) {
			delegue.setLocation(x, y);
			messageBouger();
		}

	}

	protected Point2D centreGravite;

	public FormeAbstraite(Point2D p) {
		centreGravite = new PointCentre(p);
	}

	public Point2D centreGravite() {
		return centreGravite;
	}

	public void placer(Point2D nouveauCentreGravite) {
		centreGravite.setLocation(nouveauCentreGravite);
	}

	public void translater(double dx, double dy) {
		centreGravite.setLocation(centreGravite.getX() + dx, centreGravite
				.getY()
				+ dy);
	}
	
	private void messageBouger() {
		System.out.println("Je bouge en " + centreGravite.getX() + "," + centreGravite.getY());
	}

	public String toString() {
		return this.getClass().getName() + " de centre ("
				+ centreGravite.getX() + "," + centreGravite.getY() + ")";
	}
}
