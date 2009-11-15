package automaton;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Set;

public class NotDeterministicAutomaton<T> {

	private Set<State> initialStates = new HashSet<State>();

	private final T epsilon;

	/*
	 * In the map transitions, at each state s we associate a map m where the
	 * values are the transitions having s as source and the corresponding key
	 * the labels of the transitions.
	 * 
	 */
	private final Map<State, Map<T, Set<Transition<T>>>> transitions;

	public NotDeterministicAutomaton(Transition<T>[] transitions, T epsilon)
			throws UnknownInitialStateException {
		this.transitions = new HashMap<State, Map<T, Set<Transition<T>>>>();
		this.epsilon = epsilon;
		for (Transition<T> t : transitions) {
			addState(t.source());
			addState(t.target());
			Map<T, Set<Transition<T>>> map = this.transitions.get(t.source());
			Set<Transition<T>> st;
			if (map.containsKey(t.label())) {
				st = map.get(t.label());
			} else {
				st = new HashSet<Transition<T>>();
				map.put(t.label(), st);
			}
			st.add(t);
		}
		if (initialStates.isEmpty()) {
			throw new UnknownInitialStateException();
		}
	}

	protected final void addState(State e) {
		if (!transitions.containsKey(e)) {
			if (e.initial()) {
				initialStates.add(e);
			}
			transitions.put(e, new HashMap<T, Set<Transition<T>>>());
		}
	}

	public Iterator<State> initialStates() {
		return initialStates.iterator();
	}

	/**
	 * @exception NoSuchElementException
	 *                if the <tt>source</tt> does not belong to the automaton.
	 */
	public Iterator<Transition<T>> transitions(State source, T label) {
		final Iterator<Transition<T>> EMPTY_ITERATOR = new Iterator<Transition<T>>() {

			public boolean hasNext() {
				return false;
			}

			public Transition<T> next() {
				throw new NoSuchElementException();
			}

			public void remove() {
				throw new IllegalStateException();
			}
		};

		if (!transitions.containsKey(source)) {
			throw new NoSuchElementException();
		}
		if (transitions.get(source).containsKey(label))
			return transitions.get(source).get(label).iterator();
		else
			return EMPTY_ITERATOR;
	}

	public boolean recognize(T[] word) {
		for (State s : initialStates) {
			if (recognize(s, word, 0)) {
				return true;
			}
		}
		return false;
	}

	private boolean recognize(State s, T[] word, int i) {
		if (i == word.length) {
			if (s.terminal())
				return true;
		} else for (Iterator<Transition<T>> it1 = transitions(s, word[i]); it1
				.hasNext();) {
			if (recognize(it1.next().target(), word, i + 1))
				return true;
		}
		for (Iterator<Transition<T>> it1 = transitions(s, epsilon); it1
				.hasNext();) {
			if (recognize(it1.next().target(), word, i))
				return true;
		}
		return false;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		Set<State> terminalStates = new HashSet<State>();
		for (Map<T, Set<Transition<T>>> m : transitions.values())
			for (Set<Transition<T>> s : m.values())
				for (Transition<T> t : s) {
					if (t.source().terminal())
						terminalStates.add(t.source());
					if (t.target().terminal())
						terminalStates.add(t.target());
					sb.append("[" + t.source() + ", " + t.label() + ", "
							+ t.target() + "] ");
				}
		StringBuffer sb2 = new StringBuffer();
		sb2.append("I : ");
		sb2.append(initialStates.toString());
		sb2.append("\nT : ");
		sb2.append(terminalStates.toString());
		return sb2.toString() + "\n" + sb.toString();
	}
}
