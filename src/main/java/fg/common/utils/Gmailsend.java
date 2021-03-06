package fg.common.utils;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.swing.JOptionPane;

import org.apache.log4j.Logger;

public class Gmailsend {
	Logger log = Logger.getLogger(this.getClass());
	// action
	public void GmailSet(String user, String text, String content) {
		Properties p = System.getProperties();
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.port", "587");

		Authenticator auth = new authenmail();

		Session session = Session.getDefaultInstance(p, auth);
		MimeMessage msg = new MimeMessage(session);
		String fromName = "FG game";
		String charSet = "UTF-8";

		try {
			msg.setSentDate(new Date());

			InternetAddress from = new InternetAddress();
			from = new InternetAddress(new String(fromName.getBytes(charSet), "8859_1") + "<yjsung07@gmail.com>");
			msg.setFrom(from);

			InternetAddress to = new InternetAddress(user);
			msg.setRecipient(Message.RecipientType.TO, to);
			
			msg.setSubject(text, "UTF-8");
			msg.setText(content, "UTF-8");
			Transport.send(msg);

			log.debug(" Send Email \t:  Success");
		} catch (AddressException addr_e) {
            JOptionPane.showMessageDialog(null, "메일을 입력해주세요", "메일주소입력", JOptionPane.ERROR_MESSAGE);
            addr_e.printStackTrace();
        } catch (MessagingException msg_e) {
            JOptionPane.showMessageDialog(null, "메일을 제대로 입력해주세요.", "오류발생", JOptionPane.ERROR_MESSAGE);
            msg_e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
