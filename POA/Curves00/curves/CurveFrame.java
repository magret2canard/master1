package curves;

import java.awt.BorderLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 * A class  to represent the variations of some function  in some interval.
 * Allows some control on the accuracy of this representation
 */

/**
 * @author casteran
 */
public class CurveFrame extends JFrame {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** the graphic part of the display */
	protected CurveTracer tracer;

	/** information bar */
	protected CurveInfos infos;

	/** various commands */
	protected CurveControls controls;

	/**
	 * Builds a top-level window from the variations of a function
	 * 
	 * @see FunctionVariations
	 */
	public CurveFrame(FunctionVariations fvar) {
		super("Curve");
		tracer = new CurveTracer(fvar);
		infos = new CurveInfos(fvar);
		controls = new CurveControls(fvar, this);

		JPanel mainPane = new JPanel(new BorderLayout());

		mainPane.add(tracer, BorderLayout.CENTER);
		mainPane.add(infos, BorderLayout.SOUTH);
		mainPane.add(controls, BorderLayout.EAST);

		setContentPane(mainPane);
		pack();
		setVisible(true);
	}
}
