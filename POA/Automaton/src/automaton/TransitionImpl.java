package automaton;

public class  TransitionImpl <T> implements Transition <T> {
	private T label;
	private State source;
	private State target;
	
	public TransitionImpl (State source, State target, T label){
		this.source = source;
		this.target = target;
		this.label = label;
	}
	public State source(){
		return source;
	}

	public State target(){
		return target;
	}

	public T label(){
		return label;
	}

}
