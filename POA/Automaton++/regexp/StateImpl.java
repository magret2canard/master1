package regexp;

import automaton.State;

public class StateImpl implements State {
	private boolean initial, terminal;
	private static int counter = 0;
	public final int id;

	public StateImpl(){
		id = counter++;
	}

	public boolean initial() {
		return initial;
	}

	public boolean terminal() {
		return terminal;
	}

	public void setInitial() {
		initial = true;
	}
	
	public void setTerminal() {
		terminal = true;
	}
	
	public String toString() {
		return "state " + id;
	}
}
