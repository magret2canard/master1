package curves;

import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;

/**
 * @author casteran
 */

class CurveControls extends JPanel {
	private static final long serialVersionUID = 1L;

	protected final static Integer nStepsChoices[] = { 1, 2, 3, 4, 5, 10, 20,
			40, 80, 160, 320, 640 };

	private JComboBox cb;

	CurveControls(final FunctionVariations var, final CurveFrame f) {
		super();
		JPanel precision = new JPanel();
		JLabel title = new JLabel("Précision");
		cb = new JComboBox(nStepsChoices);

		precision.add(title);
		precision.add(cb);
		add(precision);
		cb.setSelectedIndex(nStepsChoices.length / 2);
	}
}
