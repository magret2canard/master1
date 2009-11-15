package automaton;

public class TestAutomaton {


	 
	@SuppressWarnings("unchecked")
	
	public static void main(String[] args){
		String a = "a";
		String b = "b";
		
		/* -------------------- Automate reconnaissant le langage a*b --------------------*/
			
		State etat_1 = new StateImpl(true, false);
		State etat_2 = new StateImpl(false, true);
		
		Transition<String> t1 = new TransitionImpl <String>(etat_1, etat_1, a); //boucle: etat_1 ---a---> etat_1
		Transition<String> t2 = new TransitionImpl <String>(etat_1, etat_2, b); //trans:  etat_1 ---b---> etat_2
		
		DeterministicAutomaton<String> automate1 = null;
		
		String[] aaab = {a, a, a, b };
		String[] aaba = {a, a, b, a };
		
		try{
			 automate1 = new DeterministicAutomaton<String>(t1, t2);
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
		
		Transition<String> t_a = new TransitionImpl<String>(s1, s2, a);
		Transition<String> t_b = new TransitionImpl<String>(s2, s1, b);
		
		DeterministicAutomaton<String> automate2 = null;
		
		String[] ababab = {a, b, a, b, a, b };
		String[] aababb = {a, a, b, a, b, b };
		
		try{
			 automate2 = new DeterministicAutomaton <String>(t_a, t_b);
		}catch(NotDeterministicInitalStateException e){
			System.out.println(e);
		}
		catch(NotDeterministicTransitionException e){
			System.out.println(e);
		}
		catch(UnknownInitialStateException e){
			System.out.println(e);
		}
		catch(Exception e){
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
	
	 private static <T> void  testRecognize(DeterministicAutomaton<T> automate, T [] mot){
		 System.out.print(ObjectTabtoString(mot)+" est ...");
			if (automate.recognize(mot))
				System.out.println(" reconnu !");
			else
				System.out.println(" non reconnu !");
	}
}
