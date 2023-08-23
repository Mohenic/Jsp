package sub3;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class MySessionListener implements HttpSessionListener {

	public MySessionListener() {
		System.out.println("MySessionListener()...");
	}
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		System.out.println("sessionCreated()...");
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		System.out.println("sessionDestroyed()...");
	}
	
}
