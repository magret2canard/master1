package automaton;

public interface Transition {

	public State source();

	public State target();

	public Object label();
}