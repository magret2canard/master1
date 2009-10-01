package automaton;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.NoSuchElementException;

public class DeterministicAutomaton {

	private State initialState = null;

	/*
	 * In the map transitions, at each state s we associate a map m where the
	 * values are the transitions having s as source and the corresponding key
	 * the labels of the transitions.
	 * 
	 */
	
	private final Map<State, Map<Object, Transition>> transitions;


	
	public DeterministicAutomaton(Transition... transitions) throws NotDeterministicTransitionException, 
																	UnknownInitialStateException, 
																	NotDeterministicInitalStateException 
	{
		this.transitions = new HashMap<State, Map<Object, Transition>>();
		for (Transition t : transitions) {
			addState(t.source());
			addState(t.target());
			Map<Object, Transition> map = this.transitions.get(t.source());
			
			//On regarde si la transition existe déjà dans notre automate
			if(transition(t.source(), t.label()) != null)  
				throw new NotDeterministicTransitionException(t);
			
			map.put(t.label(), t);
		}
		
		if(initialState() == null)
			throw new UnknownInitialStateException();
	}
	

	protected final void addState(State e) throws NotDeterministicInitalStateException {
		if (!transitions.containsKey(e)) {
			transitions.put(e, new HashMap<Object, Transition>());
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
	
	public Transition transition(State s, Object label){
		if(! transitions.containsKey(s))
			throw new NoSuchElementException();
		else{
			Map<Object, Transition> map = transitions.get(s);
			if(map.containsKey(label))
				return map.get(label);
			else
				return null;
		}
	}
	
	public State changementEtat(Transition t){
		return t.target();
	}
	
	public boolean recognize(Iterator<Object> word){
		State s =  initialState();	
		Transition t;	
		while(word.hasNext()){
			Object letter = word.next();
			//System.out.println(letter);
			t = transition(s, letter);
			if(t == null)
				return false;
			else
				s = changementEtat(t); //s = t.target();
		}
		
		/*for(Object letter : word){
			t = transition(s, letter);
			if(t == null)
				return false;
			else
				s = changementEtat(t); //s = t.target();
			
		}*/
		return s.terminal();
	}
	
	public boolean recognize(Object [] word){
		return recognize(Arrays.asList(word).iterator());
	}
	
	
}
