package formes;

import java.awt.geom.Point2D;

public class TestFormes {
	public static void main(String args[]) {
		Rectangle r = new Rectangle(new Point2D.Double(Double.parseDouble(args[0]), Double
				.parseDouble(args[1])), Double.parseDouble(args[2]), Double
				.parseDouble(args[3]));
		Cercle c = new Cercle(new Point2D.Double(Double.parseDouble(args[4]), Double
				.parseDouble(args[5])), Double.parseDouble(args[6]));
		System.out.println(r.surface());
		System.out.println(c.perimetre());
	}
}
