package formes;

import java.awt.Color;
import java.awt.geom.Point2D;

public class FormesColoreesImpl implements FormesColorees{
	private Color fond;
	private Color encre;
	private Formes forme;
	
	public FormesColoreesImpl(Formes forme, Color fond, Color encre){
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
	
	public Point2D centreGravite() {
		return forme.centreGravite();
	}

	public void placer(Point2D nouveauCentreGravite) {
		forme.placer(nouveauCentreGravite);
	}

	public void translater(double dx, double dy) {
		forme.translater(dx, dy);
	}
}
