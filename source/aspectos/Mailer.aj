package aspectos;

import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.aspectj.lang.reflect.MethodSignature;

public aspect Mailer {

	pointcut mailer(): call(public * uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos.calcularPago*(..));

	after() returning(Object r): mailer(){
		println("------Mailer----------------------");
		double value = (double) r;
		if (value >= 2000000) {
			println("Sending Mail for car of " + value);
			SendEmail(value);
		} else
			println("Wont't send Mail for car of " + value);
	}

	static final void println(String s) {
		System.out.println(s);
	}

	public void SendEmail(double value) {
		println("Sending Email.......");
		// Have to do some security steps but it will work with a google mail
		// After that remove comments
		/*
		 * final String username = "this.is.mail@gmail.com"; final String
		 * password = "Your Password!";
		 * 
		 * Properties props = new Properties();
		 * props.put("mail.smtp.starttls.enable", "true");
		 * props.put("mail.smtp.auth", "true"); props.put("mail.smtp.host",
		 * "smtp.gmail.com"); props.put("mail.smtp.port", "587");
		 * 
		 * Session session = Session.getInstance(props, new
		 * javax.mail.Authenticator() { protected PasswordAuthentication
		 * getPasswordAuthentication() { return new
		 * PasswordAuthentication(username, password); } });
		 * 
		 * try {
		 * 
		 * Message message = new MimeMessage(session); message.setFrom(new
		 * InternetAddress("j.aguilar@getcaesium.com"));
		 * message.setRecipients(Message.RecipientType.TO,
		 * InternetAddress.parse("jfsanchezaguilar@gmail.com"));
		 * message.setSubject("Mailer Impuest AspectJ");
		 * message.setText("Dear Mail Crawler," + "\n\n There is a car with " +
		 * value + " tax! Check it!");
		 * 
		 * Transport.send(message);
		 * 
		 * System.out.println("Done");
		 * 
		 * } catch (MessagingException e) { throw new RuntimeException(e); }
		 */
	}
}
