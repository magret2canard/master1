package formes;

import java.awt.Color;

public interface FormeColoree extends Forme {

	public Color couleurFond();

	public Color couleurEncre();

	public void changerCouleurFond(Color nouvelleCouleur);

	public void changerCouleurEncre(Color nouvelleCouleur);
}