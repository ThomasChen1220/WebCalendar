<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE jsp>
<html>
  <head>
    <title>Can Chen logged in page</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="style.css">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-client_id" content="344156581217-hppuv5kuq6j2pshvfnlro90ve03pb1m7.apps.googleusercontent.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>

  <body>
    <header>
      <div class="menu"> 
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
      <div class="home_wrapper">
        <img id ="main_img" src="img/1.PNG" alt="main-leaf">
        <div class="left_block">
          <p class="title">Sycamore Calendar</p>
          <br>
          <button id="signout_button"  onclick="toSignIn();">Sign Out</button>
        </div>
      </div>
      <div class="bottom"> 
      </div>
    </main>
    <script>
    	function toSignIn() {
    		 var auth2 = gapi.auth2.getAuthInstance();
    		    auth2.signOut().then(function () {
    		      console.log('User signed out.');
    		    });
    		 window.open("Sign-In.jsp","_self");
    	}
    	function onLoad() {
    	     gapi.load('auth2', function() {
    	       gapi.auth2.init();
    	     });
        }
    </script>
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
  </body>
</html>