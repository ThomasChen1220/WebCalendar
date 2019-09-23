package driver;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.ArrayList;

public class JDBCDriver {
	private static Connection conn = null;
	private static ResultSet rs = null;
	private static PreparedStatement ps = null;
	private static user currUser=new user();
	
	public static void test() {
		System.out.println("driver called");
	}
	public static void main(String [] args) {
		connect();
	}
	public static void connect(){
		try {
			System.out.println("h");
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost/a3?user=root&password=root&useSSL=false");
			System.out.println("h1");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void close(){
		try{
			if (rs!=null){
				rs.close();
				rs = null;
			}
			if(conn != null){
				conn.close();
				conn = null;
			}
			if(ps != null ){
				ps = null;
			}
		}catch(SQLException sqle){
			System.out.println("connection close error");
			sqle.printStackTrace();
		}
	}
	
	public static void setUser(String username, String userEmail, String img_link) {
		System.out.println("insiderSetUser");
		currUser.userName = username;
		currUser.userEmail = userEmail;
		currUser.image_link = img_link;
		System.out.println("User info set!!");
		System.out.println("username:"+currUser.userName);
		System.out.println("email:"+currUser.userEmail);
		System.out.println("img:"+currUser.image_link);
		connect();
		try {
			//System.out.println("1");
			ps = conn.prepareStatement("SELECT userEmail FROM users WHERE userEmail = '"+currUser.userEmail+"'");
			//System.out.println("2");
			rs = ps.executeQuery();
			//System.out.println("3");
			if(!rs.next()){
				System.out.println("inserting to users");
				ps = conn.prepareStatement("INSERT INTO users (userEmail, username, img_link) value (?,?,?);");
				ps.setString(1, currUser.userEmail);
				ps.setString(2, currUser.userName);
				ps.setString(3, currUser.image_link);
				ps.executeUpdate();
			}else {
				//System.out.println(rs.getString("userEmail"));
			}
			rs.close();
		}catch(SQLException sqle){
			System.out.println("SQLException in function \"setUser\"");
			sqle.printStackTrace();
		}
	}
	
	public static void updateEvent(String summary, String dateTime){
		connect();
		try {
			ps = conn.prepareStatement("SELECT dateTime, summary, userEmail FROM events WHERE userEmail = '"+currUser.userEmail+"'");
			//System.out.println("2");
			rs = ps.executeQuery();
			List<String> eventInfoAll = new ArrayList<>();
			while(rs.next()){
				eventInfoAll.add(rs.getString("dateTime")+rs.getString("summary")+rs.getString("userEmail"));
			}
			System.out.println("!!!!:");
			System.out.println(eventInfoAll.size());
			boolean exist = false;
			for(String info: eventInfoAll) {
				if(info.equals(dateTime+summary+currUser.userEmail)) {
					exist = true;
				}
			}
			if(!exist) {
				ps = conn.prepareStatement("INSERT INTO events ( dateTime, summary, userEmail) value (?,?,?);",  Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, dateTime);
				ps.setString(2, summary);
				ps.setString(3, currUser.userEmail);
				ps.executeUpdate();
			}
			rs.close();
		}catch(SQLException sqle){
			System.out.println("SQLException in function \"setUser\"");
			sqle.printStackTrace();
		}
	}
	
	public static ArrayList<user> searchUser(String input){
		ArrayList<user> result = new ArrayList<>();
		String[] arr = input.split(" ");
		try {
			ps = conn.prepareStatement("SELECT userEmail, username, img_link FROM users");
			rs = ps.executeQuery();
			while(rs.next()){
				if(rs.getString("username").equals(currUser.userName))continue;
				boolean contains = false;
				for(int i=0;i<arr.length; i++) {
					if(rs.getString("username").toLowerCase().contains(arr[i].toLowerCase())) {
						contains=true;
					}
				}
				if(contains) {
					user adding = new user();
					adding.userEmail = rs.getString("userEmail");
					adding.userName =rs.getString("username");
					adding.image_link = rs.getString("img_link");
					result.add(adding);
					
				}
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	public static ArrayList<String> getInfo(String email) {
		ArrayList<String> result=new ArrayList<>();
		try {
			ps = conn.prepareStatement("SELECT followedEmail FROM following WHERE followerEmail = '"+currUser.userEmail+"'");
			rs = ps.executeQuery();
			String following="0";
			while(rs.next()) {
				if(rs.getString("followedEmail").equals(email)) {
					following = "1";
				}
			}
			result.add(following);
			ps = conn.prepareStatement("SELECT username, img_link FROM users WHERE userEmail = '"+email+"'");
			rs = ps.executeQuery();
			if(rs.next()) {
				result.add(rs.getString("username"));
				result.add(rs.getString("img_link"));
				//get events info
				ps = conn.prepareStatement("SELECT dateTime, summary FROM events WHERE userEmail = '"+email+"'");
				rs = ps.executeQuery();
				while(rs.next()) {
					System.out.println(rs.getString("summary"));
					result.add(rs.getString("summary"));
					result.add(rs.getString("dateTime"));
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public static void setFollow(String email) {
		try {
			ps = conn.prepareStatement("INSERT INTO following ( followerEmail, followedEmail) value (?,?);");
			ps.setString(1, currUser.userEmail);
			ps.setString(2, email);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static ArrayList<user> userFollowing() {
		ArrayList<user> result = new ArrayList<>();
		try {
			ps = conn.prepareStatement("SELECT followedEmail FROM following where followerEmail = '"+currUser.userEmail+"'");
			rs = ps.executeQuery();
			ArrayList<String> resultEmails = new ArrayList<>();
			while(rs.next()) {
				resultEmails.add(rs.getString("followedEmail"));
			}
			for(String email:resultEmails){
				ps = conn.prepareStatement("SELECT userEmail, username, img_link FROM users where userEmail = '"
											+email+"'");
				rs = ps.executeQuery();
				if(rs.next())
				{
					user adding = new user();
					adding.userEmail = rs.getString("userEmail");
					adding.userName =rs.getString("username");
					adding.image_link = rs.getString("img_link");
					result.add(adding);
				}
			}
			System.out.println("outOfHere!");
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
