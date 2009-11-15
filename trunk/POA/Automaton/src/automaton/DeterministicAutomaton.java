package automaton;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.NoSuchElementException;

public class DeterministicAutomaton <T> {

	private State initialState = null;

	/*
	 * In the map transitions, at each state s we associate a map m where the
	 * values are the transitions having s as source and the corresponding key
	 * the labels of the transitions.
	 * 
	 */
	
	private final Map<State, Map<T, Transition<T>>> Transitions;


	
	public DeterministicAutomaton(Transition<T>... Transitions) throws NotDeterministicTransitionException, 
																	UnknownInitialStateException, 
																	NotDeterministicInitalStateException 
	{
		this.Transitions = new HashMap<State, Map<T, Transition<T>>>();
		for (Transition<T> t : Transitions) {
			addState(t.source());
			addState(t.target());
			Map<T, Transition<T>> map = this.Transitions.get(t.source());
			
			//On regarde si la Transition existe déjà dans notre automate
			if(Transition(t.source(), t.label()) != null)  
				throw new NotDeterministicTransitionException(t);
			
			map.put(t.label(), t);
		}
		
		if(initialState() == null)
			throw new UnknownInitialStateException();
	}
	

	protected final void addState(State e) throws NotDeterministicInitalStateException {
		if (!Transitions.containsKey(e)) {
			Transitions.put(e, new HashMap<T, Transition<T>>());
			if (e.initial()) {
				if (initialState == null) {
					initialState = e;
				}
				else throw new NotDeterministicInitalStateException(e, initialState);
					
			}
		}
	}
	
	public State initialState(){
		return initialState;
	}
	
	public Transition<T> Transition(State s, T label) throws NoSuchElementException{
		if(! Transitions.containsKey(s))
			throw new NoSuchElementException();
		else{
			Map<T, Transition<T>> map = Transitions.get(s);
			if(map.containsKey(label))
				return map.get(label);
			else
				return null;
		}
	}
	
	public State changementEtat(Transition<T> t){
		return t.target();
	}
	
	public boolean recognize(Iterator<T> word){
		State s =  initialState();	
		Transition<T> t;	
		while(word.hasNext()){
			T letter = word.next();
			t = Transition(s, letter);
			if(t == null)
				return false;
			else
				s = changementEtat(t);
		}
		return s.terminal();
	}
	
	public boolean recognize(T [] word){
		return recognize(Arrays.asList(word).iterator());
	}
	
	
}
