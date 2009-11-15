package curves_gui;

import java.awt.Color;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class PrecisionPanel extends JPanel {
	private static final long serialVersionUID = 1L;

	public PrecisionPanel(){
		super();
		this.setBackground(Color.WHITE);
		//this.setLayout(new SpringLayout());
		
		
		this.add(new JLabel("Precision: "));
		this.add(new JLabel("Precision2: "));
		this.add(new PrecisionComboBox());
	}
}
