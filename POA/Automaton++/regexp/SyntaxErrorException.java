package regexp;

public class SyntaxErrorException extends Exception {
	private static final long serialVersionUID = 1080131296249130969L;

	private String msg;

	public SyntaxErrorException(String msg) {
		this.msg = msg;
	}

	public SyntaxErrorException() {
		this("");
	}

	public String getMessage() {
		return "Syntax error" + msg;
	}
}
