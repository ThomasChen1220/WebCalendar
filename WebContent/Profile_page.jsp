<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="driver.*"%>
<!DOCTYPE jsp>
<html>
  <head>
    <title>Can Chen sign in page</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="style.css">
    <script src="function.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  	<% 
  		//String name = id="userName"
		//JDBCDriver.updateUser(String username, String userEmail, String img_link, String eventsRaw);
 	%>
  <body>
    <header>
      <div class="menu"> 
        <div class="right_nav">
          <a href="logged-in.jsp">Sycamore Calendar</a>
        </div>
        
        <div class="left_nav">
          <div id="search_bar">
            <form action="Search.jsp">
              <input id="searchInput" type="text" placeholder="Search Friend" name="search">
              <button type="submit" onClick="cookieSearch();"><i class="fa fa-search"></i></button>
            </form>
          </div>
          <a href="Profile_page.jsp">Profile</a>
          <a href="Home_Page.jsp">Home</a>
        </div>
      </div>
    </header>
    <main>
      <div class="content_wrapper">
        <h1>Upcoming Events</h1>
        <div class="events">
          <form >
            <table id="mForm">
              <tr>
                <th>Date</th>
                <th>Time</th>
                <th>Event Summary</th>
              </tr>
            </table>
          </form>
        </div>
        <div class="left_img">
          <img id ="photo" src="img/photo.PNG" alt="main-leaf">
          <h1 id="userName">No Name</h1>
          <pre id="content"></pre>
        </div>
      </div>
      <div class="bottom"> 
      </div>
    </main>
    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
  </body>
</html>