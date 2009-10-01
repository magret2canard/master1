package automaton;

public class StateImpl implements State {
	private boolean initial;
	private boolean terminal;
	
	public StateImpl(boolean initial, boolean terminal){
		this.initial = initial;
		this.terminal = terminal;
	}
	
	public boolean initial(){
		return initial;
	}

	public boolean terminal(){
		return terminal;
	}

}
