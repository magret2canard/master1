package curves_gui;


import javax.swing.JComboBox;

public class PrecisionComboBox extends JComboBox{
	private static final long serialVersionUID = 1L;
	static String[] petStrings = { "Bird", "Cat", "Dog", "Rabbit", "Pig" };

	public PrecisionComboBox(){	
		super(petStrings);
		this.setSelectedIndex(4);
	}

}
