package automaton;

public class NotDeterministicInitalStateException extends Exception {
	private static final long serialVersionUID = 1L;
	
	private State old_initial;
	private State new_initial;
	
	public NotDeterministicInitalStateException(State old_initial, State new_initial){
		this.old_initial = old_initial;
		this.new_initial = new_initial;
	}
	
	public State state1(){
		return old_initial;
	}
	
	public State state2(){
		return new_initial;
	}
	
	public String toString(){
		return new String ("Deux éléments de transitions ont la même source et la même étiquette");
	}
}

