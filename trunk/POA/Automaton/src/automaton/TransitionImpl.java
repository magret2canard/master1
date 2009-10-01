package automaton;

public class TransitionImpl implements Transition {
	private Object label;
	private State source;
	private State target;
	
	public TransitionImpl(State source, State target, Object label){
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

	public Object label(){
		return label;
	}

}
