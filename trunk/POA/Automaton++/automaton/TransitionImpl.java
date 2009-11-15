package automaton;

public class TransitionImpl<T> implements Transition<T> {
	private final State source;

	private final State target;

	private final T label;

	public TransitionImpl(State source, State target, T label) {
		this.source = source;
		this.target = target;
		this.label = label;
	}

	public State target() {
		return target;
	}

	public T label() {
		return label;
	}

	public State source() {
		return source;
	}

	public String toString() {
		return "transition : " + source + ", " + '"' + label + '"' + ", "
				+ target;
	}
}
