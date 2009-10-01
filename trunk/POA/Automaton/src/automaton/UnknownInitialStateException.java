package automaton;

public class UnknownInitialStateException extends Exception {
	private static final long serialVersionUID = 1L;
		
	public UnknownInitialStateException(){
	}
	
	public String toString(){
		return new String("Parmi tous les �tats source ou cible d'une transition de transitions, " +
				           "il n'existe aucun �tat initial.");
	}
	
}
