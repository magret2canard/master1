package automaton;

public class NotDeterministicTransitionException extends Exception{
	private static final long serialVersionUID = 1L;
	
	private Transition t;
	
	public NotDeterministicTransitionException(Transition t){
		this.t = t;
	}
	
	public Transition transition(){
		return t;
	}
	
	public String toString(){
		return new String("Deux éléments de transitions ont la même source et la même étiquette,");
	}
}
