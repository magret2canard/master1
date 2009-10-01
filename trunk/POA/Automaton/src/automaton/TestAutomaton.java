package automaton;

public class TestAutomaton {


	 
	public static void main(String[] args){
		char a = 'a';
		char b = 'b';
		
		/* -------------------- Automate reconnaissant le langage a*b --------------------*/
			
		State etat_1 = new StateImpl(true, false);
		State etat_2 = new StateImpl(false, true);
		
		Transition t1 = new TransitionImpl(etat_1, etat_1, a); //boucle: etat_1 ---a---> etat_1
		Transition t2 = new TransitionImpl(etat_1, etat_2, b); //trans:  etat_1 ---b---> etat_2
		
		DeterministicAutomaton automate1 = null;
		
		Object[] aaab = {a, a, a, b };
		Object[] aaba = {a, a, b, a };
		
		try{
			 automate1 = new DeterministicAutomaton(t1, t2);
		}catch(Exception e){
			System.out.println("Il y a une erreur "+e);
		}
		
		System.out.println("Automate 1 : L = a*b");
		
		testRecognize(automate1, aaab);
		testRecognize(automate1, aaba);
		
		System.out.println();
			
		/* -------------------- Automate reconnaissant le langage (ab)* --------------------*/
		
		State s1 = new StateImpl(true, true);
		State s2 = new StateImpl(false, false);
		
		Transition t_a = new TransitionImpl(s1, s2, a);
		Transition t_b = new TransitionImpl(s2, s1, b);
		
		DeterministicAutomaton automate2 = null;
		
		Object[] ababab = {a, b, a, b, a, b };
		Object[] aababb = {a, a, b, a, b, b };
		
		try{
			 automate2 = new DeterministicAutomaton(t_a, t_b);
		}catch(Exception e){
			System.out.println("Il y a une erreur "+e);
		}
		
		System.out.println("Automate 2 : L = (ab)*");
		
		testRecognize(automate2, ababab);
		testRecognize(automate2, aababb);
		
		System.out.println();
	}
	
	
	private static String ObjectTabtoString(Object[] tab){
		StringBuffer s = new StringBuffer();
		for(int i=0; i < tab.length; i++)
			s.append(tab[i]);
		return s.toString();
	}
	
	 private static void  testRecognize(DeterministicAutomaton automate, Object[] mot){
		 System.out.print(ObjectTabtoString(mot)+" est ...");
			if (automate.recognize(mot))
				System.out.println(" reconnu !");
			else
				System.out.println(" non reconnu !");
	}
}
