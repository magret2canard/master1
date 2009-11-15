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
		
		build();//On initialise notre fen�tre
	}
	
	private void build(){
		setTitle("Calculatrice"); //On donne un titre � l'application
		setSize(640,480); //On donne une taille � notre fen�tre
		setLocationRelativeTo(null); //On centre la fen�tre sur l'�cran
		setResizable(false); //On interdit la redimensionnement de la fen�tre
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //On dit � l'application de se fermer lors du clic sur la croix
	}
}
