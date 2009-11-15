package curves_gui;

import java.awt.Color;
import java.awt.GridLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;

public class ValorsPanel extends JPanel{
	private static final long serialVersionUID = 1L;
	
	public ValorsPanel(){
		this.setBackground(Color.ORANGE);
		

			this.setLayout(new GridLayout(0,2));

			this.add(new JLabel("xmin = -6.432545465465465463463"));
			this.add(new JLabel("ymin = -6.432545465465465463463"));
			this.add(new JLabel(""));
			this.add(new JLabel(""));
			this.add(new JLabel("sum = -6.432545465465465463463"));
			this.add(new JLabel("xmax = -6.432545465465465463463"));
			this.add(new JLabel(""));
			this.add(new JLabel(""));
			this.add(new JLabel("ymax = -6.432545465465465463463"));
			this.add(new JLabel(""));
			this.add(new JLabel(""));
			

	}

}
