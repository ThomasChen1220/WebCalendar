package driver;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/MyServlet")
public class MyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String field= request.getParameter("field");
		//PrintWriter out = response.getWriter();
		System.out.println("called servlet:"+field);
		System.out.println(field);
		if(field.equals("userInfo")) {
			System.out.println("senting Driver");
			String username= request.getParameter("username");
			String useremail= request.getParameter("userEmail");
			String img_link= request.getParameter("img_link");
			System.out.println("senting Driver");
			JDBCDriver.setUser(username, useremail, img_link);
		}
		if(field.equals("eventInfo")) {
			System.out.println("servlet in event info");
			String summary= request.getParameter("summary");
			String dateTime= request.getParameter("dateTime");
			JDBCDriver.updateEvent(summary, dateTime);
		}
		if(field.equals("search")) {
			PrintWriter out = response.getWriter();
			System.out.println("servlet in search");
			String input= request.getParameter("input");
			ArrayList<user> resultUsers = JDBCDriver.searchUser(input);
			for(user u: resultUsers) {
				out.println("<div class=\"one_third\" onClick=\"cookieEmail('"+u.userEmail+"')\">\r\n" + 
								"<img src=\""+ u.image_link +"\" alt=\"main-leaf\">\r\n" + 
								"<h3>"+u.userName+"</h3>\r\n" + 
							"</div>");
			}
			if(resultUsers.size()==0) {
				out.println("<h1>No User Found</h1>");
			}
		}
		if(field.equals("following")) {
			PrintWriter out = response.getWriter();
			String email= request.getParameter("email");
			ArrayList<String> allInfo = JDBCDriver.getInfo(email);
			System.out.println("Start");
			for(String info: allInfo) {
				out.println(info);
				System.out.println(info);
			}
			System.out.println("end");
		}
		if(field.equals("followHer")) {
			String email= request.getParameter("email");
			JDBCDriver.setFollow(email);
			System.out.println("followed: "+email);
		}
		if(field.equals("homeFollow")) {
			PrintWriter out = response.getWriter();
			ArrayList<user> resultUsers = JDBCDriver.userFollowing();
			out.println("<h2>Following</h2>");
			for(user u: resultUsers) {
				System.out.println(u.userName);
				out.println("<div class=\"one_fourth\" onClick=\"cookieEmail('"+u.userEmail+"')\">\r\n" + 
								"<img src=\""+ u.image_link +"\" alt=\"main-leaf\">\r\n" + 
								"<h3>"+u.userName+"</h3>\r\n" + 
							"</div>");
			}
		}
	}
}
