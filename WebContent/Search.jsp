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
      <br><br><br><br><br><br><br><br><br><br><br>
      <div id="search_result" class="follow_wrapper">
        <div class="one_third" onClick="cookieEmail('a@d.com')">
          <img src="img/photo.PNG" alt="main-leaf">
          <h3>name</h3>
          
        </div>
        <div class="one_third">
          <img src="img/photo.PNG" alt="main-leaf">
          <h3>name</h3>
        </div>
        <div class="one_third">
          <img src="img/photo.PNG" alt="main-leaf">
          <h3>name</h3>
        </div>
        <div class="one_third">
          <img src="img/photo.PNG" alt="main-leaf">
          <h3>name</h3>
        </div>
        <div class="one_third">
          <img src="img/photo.PNG" alt="main-leaf">
          <h3>name</h3>
        </div>
        <div class="one_third">
          <img src="img/photo.PNG" alt="main-leaf">
          <h3>name</h3>
        </div>
        <div class="one_third">
          <img src="img/photo.PNG" alt="main-leaf">
          <h3>name</h3>
        </div>
      </div>
      <br><br><br><br><br><br><br>
      <div class="bottom"> </div>
    </main>
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
    
    <script> search(document.cookie.split(';')[1].substring(1)); </script>
  </body>
</html>