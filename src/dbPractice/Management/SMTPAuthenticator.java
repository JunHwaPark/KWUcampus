package dbPractice.Management;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
 
public class SMTPAuthenticator extends Authenticator{
 
	private String id, pass;
	
	public SMTPAuthenticator(String id, String pass) {
		this.id = id;
		this.pass = pass;
	}
    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(this.id, this.pass);
    }
}