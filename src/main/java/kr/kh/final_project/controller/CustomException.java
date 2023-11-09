package kr.kh.final_project.controller;

public class CustomException extends Exception {
	private static final long serialVersionUID = -8867047833417185555L;

	public CustomException() {
	        super();
	    }

	    public CustomException(String message) {
	        super(message);
	    }

	    public CustomException(String message, Throwable cause) {
	        super(message, cause);
	    }

	    public CustomException(Throwable cause) {
	        super(cause);
	    }
}
