package curves_gui;

import java.awt.BorderLayout;
import java.awt.Container;

import javax.swing.JFrame;

public class CurvesFrame extends JFrame{
	private static final long serialVersionUID = 1L;
	
	public CurvesFrame(){
		super();
		
		Container pane = getContentPane();
		pane.setLayout(new BorderLayout()); //Choix du layout
		

		//pane.add(new CurvesComponent());//Ajout du component
		pane.add(new ValorsPanel(), BorderLayout.PAGE_END);
		pane.add(new PrecisionPanel(), BorderLayout.LINE_END);
		
		build();//On initialise notre fenêtre
	}
	
	private void build(){
		setTitle("Calculatrice"); //On donne un titre à l'application
		setSize(640,480); //On donne une taille à notre fenêtre
		setLocationRelativeTo(null); //On centre la fenêtre sur l'écran
		setResizable(false); //On interdit la redimensionnement de la fenêtre
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //On dit à l'application de se fermer lors du clic sur la croix
	}
}
