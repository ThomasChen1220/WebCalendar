<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE jsp>
<html>
  <head>
    <title>Can Chen sign in page</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="style.css">
    <script src="function.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>

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
        <h1>Home</h1>
        <div class="form_wrapper">
          <div class="left_img">
            <img id ="photo" src="img/photo.PNG" alt="main-leaf">
            <h1 id = "userName">No Name</h1>
            <pre id="content"></pre>
          </div>
          <form class="addE">
            <div class="left_add">
              <input type="text" id="eTitle" name="eTitle" value ="Event Title">
              <input type="date" id="eSDate" name="eSDate" >
              <input type="date" id="eEDate" name="eEDate" >
              <input type="time" id="eSTime" name="eSTime" >
              <input type="time" id="eETime" name="eETime" >
            </div>
            <input id="submit" type="button" value="Add Event" onclick="addEvent();">
            <pre id="error"></pre>
          </form>
          <div class="follow_wrapper" id="follow_display">
            <h2>Following</h2>
            <div class="one_fourth">
              <img src="img/photo.PNG" alt="main-leaf">
              <h3>name</h3>
            </div>
            <div class="one_fourth">
              <img src="img/photo.PNG" alt="main-leaf">
              <h3>name</h3>
            </div>
            <div class="one_fourth">
              <img src="img/photo.PNG" alt="main-leaf">
              <h3>name</h3>
            </div>
            <div class="one_fourth">
              <img src="img/photo.PNG" alt="main-leaf">
              <h3>name</h3>
            </div>
            <div class="one_fourth">
              <img src="img/photo.PNG" alt="main-leaf">
              <h3>name</h3>
            </div>
          </div>
          
        </div>
      </div>
      <br><br><br><br><br><br><br>
      <div class="bottom"> 
      </div>
    </main>
    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
    
    <script> showFollowing();</script>
  </body>
</html>