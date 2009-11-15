package regexp;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import automaton.Transition;

class AutomatonData {
	Set<StateImpl> terminalStates;
	Set<StateImpl> initialStates;
	List<Transition<String>> transitions;
	
	public AutomatonData(){
		this.initialStates = new HashSet<StateImpl>();
		this.terminalStates = new HashSet<StateImpl>();
		this.transitions = new ArrayList<Transition<String>>();
	}
}
