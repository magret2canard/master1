package regexp;


import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreeNode;

import java.util.List;

import automaton.*;


public class AutomatonBuilder {

	private static final Operator OR = new Operator() {
		private final static String symbol = "|";
		
		public int arity() {
			return 2;
		}

		public AutomatonData build(AutomatonData[] args) {
			AutomatonData result = new AutomatonData();	
			AutomatonData auto1 = args[0];
			AutomatonData auto2 = args[1];
			
			result.initialStates.addAll(auto1.initialStates);
			result.initialStates.addAll(auto2.initialStates);
			result.terminalStates.addAll(auto1.terminalStates);
			result.terminalStates.addAll(auto2.terminalStates);
			result.transitions.addAll(auto1.transitions);
			result.transitions.addAll(auto2.transitions);
			
			return result;
		}

		public String symbol() {
			return symbol;
		}
	};

	private static final Operator DOT = new Operator() {
		private final static String symbol = ".";

		public int arity() {
			return 2;
		}

		public AutomatonData build(AutomatonData[] args) {
			AutomatonData result = new AutomatonData();		
			AutomatonData auto1 = args[0];
			AutomatonData auto2 = args[1];
			
			result.initialStates.addAll(auto1.initialStates);
			
			result.terminalStates.addAll(auto2.terminalStates);
			
			result.transitions.addAll(auto1.transitions);
			result.transitions.addAll(auto2.transitions);
			
			//Le nouvel ensemble d'epsilon-transitions entre chaque Žtat terminal de auto1 et chaque Žtat initial de auto2.
			Object[] states_array_1 = auto1.terminalStates.toArray();
			Object[] states_array_2 = auto2.initialStates.toArray();
			for(int i=0; i < states_array_1.length; i++){
				for(int j=0; j < states_array_2.length; j++){
					Transition<String> t = new TransitionImpl<String>((StateImpl)states_array_1[i], (StateImpl)states_array_2[j], "");
					result.transitions.add(t);
				}
			}
			
			return result;
		}

		public String symbol() {
			return symbol;
		}
	};

	private static final Operator ITER = new Operator() {
		private final static String symbol = "*";
		
		public int arity() {
			return 1;
		}

		public AutomatonData build(AutomatonData[] args) {
			AutomatonData result = new AutomatonData();
			AutomatonData auto = args[0];
			
			StateImpl e = new StateImpl();
			e.setInitial();
			e.setTerminal();
			
			result.initialStates.add(e);
			result.terminalStates.add(e);
			
			Object[] states_array;
			
			//L'ensemble des transitions de auto:
			result.transitions.addAll(auto.transitions);
			
			//Le nouvel ensemble d'epsilon-transitions reliant e ˆ chaque Žtat initial de auto
			states_array = auto.initialStates.toArray();	
			for(int i=0; i < states_array.length; i++){
				Transition<String> t = new TransitionImpl<String>(e, (StateImpl)states_array[i], "");
				result.transitions.add(t);
			}
			
			//Le nouvel ensemble d'epsilon-transitions reliant chaque Žtat terminal de auto ˆ e
			states_array = auto.terminalStates.toArray();	
			for(int i=0; i < states_array.length; i++){
				Transition<String> t = new TransitionImpl<String>((StateImpl)states_array[i], e, "");
				result.transitions.add(t);
			}
			
			return result;
		}

		public String symbol() {
			return symbol;
		}
	};

	private static final Operator[] ops = { DOT, OR, ITER };

	private static final Map<String, Operator> operators = new HashMap<String, Operator>();

	static {
		for (Operator op : ops)
			operators.put(op.symbol(), op);
	}

	@SuppressWarnings("unchecked")
	public static NotDeterministicAutomaton<String> createAutomaton(String expression) throws SyntaxErrorException,
																							  UnknownInitialStateException {
		List<String> l = Arrays.asList(expression.split("\\s"));
		Iterator<String> its = l.iterator();
		//System.out.println("Taille : "+l.size());
		AutomatonData ad = evaluate(its, l.size());
		if (its.hasNext()){
			throw new SyntaxErrorException(" : " + its.next());
		}
		for (StateImpl s : ad.initialStates) {
			s.setInitial();
		}
		for (StateImpl s : ad.terminalStates) {
			s.setTerminal();
		}
		return new NotDeterministicAutomaton<String>(ad.transitions.toArray(new Transition[ad.transitions.size()]), "");
	}


	//Creer un automate simple 1 ----label----> 2
	private static AutomatonData createSimple(String label){
		StateImpl deb = new StateImpl();
		deb.setInitial();	
		StateImpl fin = new StateImpl();
		fin.setTerminal();		
		TransitionImpl<String> transition = new TransitionImpl<String>(deb, fin, label);
		AutomatonData  auto = new AutomatonData();
		auto.initialStates.add(deb);
		auto.terminalStates.add(fin);
		auto.transitions.add(transition);
		return auto;
	}
	
	//Transforme un tableau en arbre.
	static int index = 0;	
	private static DefaultMutableTreeNode arrayToTree(String[] array){
		Operator op;
		//System.out.println(index);
		String s = array[index];
		index++;
			DefaultMutableTreeNode node;
			if((op = operators.get(s)) != null){
				node = new DefaultMutableTreeNode(s, true);
				if(op.arity() == 2){
					//System.out.println(op.symbol());
					node.add(arrayToTree(array));
					node.add(arrayToTree(array));
					return node;
				}
				else{
					//System.out.println(op.symbol());
					node.add(arrayToTree(array));
					return node;
				}
			}
			else{
				//System.out.println(s);
				node =  new DefaultMutableTreeNode(s, false);
				return node;
			}
	}

	//Transforme un arbre en AutomatonData
	private static AutomatonData evaluate_anex(TreeNode treeNode){
		AutomatonData[] data;
		int nb_node = treeNode.getChildCount();
		switch(nb_node){
			case 0:
				return createSimple(treeNode.toString());
			case 1:
				data = new AutomatonData[1];
				data[0] = evaluate_anex(treeNode.getChildAt(0));
				return ITER.build(data);
			case 2:
				Operator op = operators.get(treeNode.toString());
				data = new AutomatonData[2];
				data[0] = evaluate_anex(treeNode.getChildAt(0));
				data[1] = evaluate_anex(treeNode.getChildAt(1));
				return op.build(data);
			default:
				return null;
		}
	}
	
	private static void parcoursPrefixe(TreeNode treeNode){
		int nb_nodes = treeNode.getChildCount();
		switch(nb_nodes){
			case 0:
				System.out.print(treeNode);
				break;
			case 1:
				System.out.print(treeNode);
				parcoursPrefixe(treeNode.getChildAt(0));
				break;
			case 2:
				System.out.print(treeNode);
				parcoursPrefixe(treeNode.getChildAt(0));
				parcoursPrefixe(treeNode.getChildAt(1));
				break;
			default:
		}
	}
	
	private static AutomatonData evaluate(Iterator<String> it, int size) throws SyntaxErrorException {
		String s;
		String[] s_array = new String[size];
		//System.out.println(sizeIterator(it));
		int i = 0;
		while(it.hasNext()){
			s = it.next();
			s_array[i] = s;
			i++;
		}
		index = 0;
		DefaultMutableTreeNode tree = arrayToTree(s_array);
		parcoursPrefixe(tree);
		System.out.println();
		return evaluate_anex(tree);
	}

}
