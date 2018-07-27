package fg.common.utils;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class authenmail extends Authenticator {
	PasswordAuthentication pa;

	public authenmail() {
		String id = "yjsung07@gmail.com";
		String pw = "syj30712";

		pa = new PasswordAuthentication(id, pw);
	}

	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}
