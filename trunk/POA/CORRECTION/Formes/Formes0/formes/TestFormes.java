package formes;

import java.awt.geom.Point2D;

public class TestFormes {
	public static void main(String args[]) {
		Rectangle r = new Rectangle(new Point2D.Double(Double.parseDouble(args[0]), Double
				.parseDouble(args[1])), Double.parseDouble(args[2]), Double
				.parseDouble(args[3]));
		System.out.println(r.surface());
	}
}
