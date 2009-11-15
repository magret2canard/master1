package regexp;

interface Operator {

	int arity();

	String symbol();

	AutomatonData build(AutomatonData[] args);
}
