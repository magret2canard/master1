import regexp.AutomatonBuilder;
import regexp.SyntaxErrorException;
import automaton.NotDeterministicAutomaton;
import automaton.UnknownInitialStateException;

public class Test {

	public static void main(String[] args) throws UnknownInitialStateException,
			SyntaxErrorException {

		// automate reconnaissant a*b* | c
		//NotDeterministicAutomaton<String> a = AutomatonBuilder.createAutomaton("| . * a * b c");
		//..............|.............
		//............/...\...........
		//...........¡.....c..........
		//........./...\..............
		//........*.....*.............
		//......./.......\............
		//......a.........b...........
		
		//System.out.println(a);

		// Seul le mot ba doit renvoyer false
		String[][] tm = { {}, { "a" }, 
							  { "a", "b", "b" }, 
							  { "b", "a" },
							  { "c" },
							  { "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a" },
							  { "a", "b", "b", "a"},
							  { "a", "b", "b" },
							  { "c", "d", "d" },
							  { "d" },
							  { "c", "c" }
								};
		/*
		for (String[] m : tm) {
			for (String s : m)
				System.out.print(s);
			System.out.println(" recognized ? " + a.recognize(m));
		}
		*/
		// automate reconnaissant a b* a 
		NotDeterministicAutomaton<String> a2 = AutomatonBuilder.createAutomaton(". a . * b a");
		//System.out.println(a2);
		
		/*
		for (String[] m : tm) {
			for (String s : m)
				System.out.print(s);
			System.out.println(" recognized ? " + a2.recognize(m));
		}
		*/
	}
}
