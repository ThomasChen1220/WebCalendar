// Client ID and API key from the Developer Console
  var CLIENT_ID = '344156581217-hppuv5kuq6j2pshvfnlro90ve03pb1m7.apps.googleusercontent.com';
  var API_KEY = 'AIzaSyAVvTdGYOBz_9hF99C2MY3ZVePlXpGdFcM';

  // Array of API discovery doc URLs for APIs used by the quickstart
  var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

  // Authorization scopes required by the API; multiple scopes can be
  // included, separated by spaces.
  var SCOPES = "https://www.googleapis.com/auth/calendar";

  var authorizeButton = document.getElementById('authorize_button');
  var signoutButton = document.getElementById('signout_button');

  /**
   *  On load, called to load the auth2 library and API client library.
   */
  function handleClientLoad() {
    gapi.load('client:auth2', initClient);
  }

  //Servlet functions
  //send user info
  function sendUser(name, email, img) {
		var xhttp = new XMLHttpRequest();
		console.log("sending user info");
		xhttp.open("GET", "MyServlet?field=userInfo&username=" + name 
												 +"&userEmail=" + email
												 +"&img_link=" + img, true);
		xhttp.send();
		console.log("sent user info");
  }
  
  function sendEvent(summary, when){
	  var xhttp = new XMLHttpRequest();
		console.log("sending event info");
		xhttp.open("GET", "MyServlet?field=eventInfo&summary=" + summary 
												 +"&dateTime=" + when, true);
		xhttp.send();
		console.log("sent event info");
  }
  
  function cookieSearch(){
	  document.cookie = document.getElementById("searchInput").value;
	  
  }
  
  function search(input){
	  console.log("in search");
	  console.log(input);
	  var xhttp = new XMLHttpRequest();
		console.log("sending search input");
		xhttp.open("GET", "MyServlet?field=search&input=" + input, true);
		xhttp.onreadystatechange = function() {
			document.getElementById("search_result").innerHTML = this.responseText;
		}
		xhttp.send();
		console.log("sent search input");
//	  console.log(input.length);
	  
  }
  
  function cookieEmail(email){
	  console.log(email);
	  document.cookie = email;
	  window.location = "User_info.jsp";
  }
  
  function showUserInfo(userEmial){
	  console.log(userEmial);
	  var xhttp = new XMLHttpRequest();
		console.log("sending followed email");
		xhttp.open("GET", "MyServlet?field=following&email=" + userEmial, true);
		xhttp.onreadystatechange = function() {
			if(this.responseText.length==0)return;
			if(document.getElementById('events_title').innerHTML!="Upcoming Events") return;
			var arr = this.responseText.split("\n");
			var following = arr[0];
			console.log("length:"+arr.length);
			console.log(arr);
			document.getElementById('userName').innerHTML = arr[1];
			document.getElementById('photo').src=arr[2];
	  		
	  		var fName =  arr[1].split(" ")[0];
	  		document.getElementById('events_title').innerHTML = fName+"'s "+document.getElementById('events_title').innerHTML;
	  		
	  		console.log("following:"+following);
	  		if(following==0){
	  		  var element;
	  		  element = document.getElementById("mForm");
	  		  if (element) {
	  			  var adding = "<tr>"+"Follow "+fName+" to viw UpComing Events"+"</tr>";
	  		      element.innerHTML += adding;
	  		  }
	  		}else{
	  			document.getElementById("follow").style.display = "none";
	  			for(var i=3; i<arr.length; i=i+2){
		  			if(arr[i]!=""&&arr[i+1]!=""){
			  			console.log(arr[i]);
			  			console.log(arr[i+1]);
			  			appendTable(arr[i], arr[i+1]);
		  			}
		  		}
	  		}
	  		console.log(arr.length);
			//document.getElementById("search_result").innerHTML = this.responseText;
		}
		xhttp.send();
		console.log("sent followed email");
  }
  
  function followHer(){
	  var xhttp = new XMLHttpRequest();
		xhttp.open("GET", "MyServlet?field=followHer&email=" + document.cookie.split(';')[1].substring(1), true);
		xhttp.onreadystatechange = function() {
			//document.getElementById("search_result").innerHTML = this.responseText;
			window.location = "User_info.jsp";
		}
		xhttp.send();
  }
  
  function showFollowing(){
	  var xhttp = new XMLHttpRequest();
		xhttp.open("GET", "MyServlet?field=homeFollow", true);
		xhttp.onreadystatechange = function() {
			document.getElementById("follow_display").innerHTML = this.responseText;
		}
		xhttp.send();
  }
  /**
   *  Initializes the API client library and sets up sign-in state
   *  listeners.
   */
  function initClient() {
    gapi.client.init({
      apiKey: API_KEY,
      clientId: CLIENT_ID,
      discoveryDocs: DISCOVERY_DOCS,
      scope: SCOPES
    }).then(function () {
    	var auth2 = gapi.auth2.getAuthInstance();
  	  	if (auth2.isSignedIn.get()) {
  		  var profile = auth2.currentUser.get().getBasicProfile();
  		  console.log('Image URL: ' + profile.getImageUrl());
  		  console.log('Full Name111: ' + profile.getName());
  		  console.log("here1");
  		  document.getElementById('photo').src=profile.getImageUrl();
  		  console.log("here1");
  		  document.getElementById('userName').innerHTML = profile.getName();
  		  //set the driver user to current user
  		  console.log("here1");
  		  sendUser(profile.getName(), profile.getEmail(), profile.getImageUrl());
  		  console.log("here2");
  		}
    	listUpcomingEvents();
    });
  }

  /**
   *  Called when the signed in status changes, to update the UI
   *  appropriately. After a sign-in, the API is called.
   */
  function updateSigninStatus(isSignedIn) {
    if (isSignedIn) {
      authorizeButton.style.display = 'none';
      signoutButton.style.display = 'block';
      
    } else {
      authorizeButton.style.display = 'block';
      signoutButton.style.display = 'none';
    }
  }

  /**
   *  Sign in the user upon button click.
   */
  function handleAuthClick(event) {
    gapi.auth2.getAuthInstance().signIn();
  }

  /**
   *  Sign out the user upon button click.
   */
  function handleSignoutClick(event) {
    gapi.auth2.getAuthInstance().signOut();
  }

  /**
   * Append a pre element to the body containing the given message
   * as its text node. Used to display the results of the API call.
   *
   * @param {string} message Text to be placed in pre element.
   */
  function appendPre(message) {
    var pre = document.getElementById('content');
    var textContent = document.createTextNode(message + '\n');
    pre.appendChild(textContent);
  }
  
  function transDate(date){
	  var monthNames = [
		    "January", "February", "March",
		    "April", "May", "June", "July",
		    "August", "September", "October",
		    "November", "December"
		  ];
	  
	  var res = date.split("-");
	  var result = monthNames[res[1]-1]+" "+ res[2]+", "+res[0];
	  return result;
  }
  function transTime(time){
	  var res = time.split(":");
	  var result;
	  if(res[0]>=12){
		  if (res[0]==12){
			  result = res[0]+":"+res[1]+" "+"PM";
		  }
		  else if(res[0]==24){
			  result = (res[0]-12)+":"+res[1]+" "+"AM";
		  }
		  else{
			  result = (res[0]-12)+":"+res[1]+" "+"PM";
		  }
	  }
	  else{
		  result = res[0]+":"+res[1]+" "+"AM";
	  }
	  return result;
  }
  
  function appendTable(name, dateTime){
	  var res = dateTime.split("T");
	  var date = transDate(res[0]);
	  var time = transTime(res[1].split("-")[0]);
	  
	  var element;
	  element = document.getElementById("mForm");
	  if (element) {
		  var adding = "<tr><td>"+date+"</td><td>"+time+"</td><td>"+name+"</td></tr>";
	      element.innerHTML += adding;
	  }
  }

  /**
   * Print the summary and start datetime/date of the next ten events in
   * the authorized user's calendar. If no events are found an
   * appropriate message is printed.
   */
  function listUpcomingEvents() {
    gapi.client.calendar.events.list({
      'calendarId': 'primary',
      'timeMin': (new Date()).toISOString(),
      'showDeleted': false,
      'singleEvents': true,
      'maxResults': 25,
      'orderBy': 'startTime'
    }).then(function(response) {
      var events = response.result.items;

      if (events.length > 0) {
        for (i = 0; i < events.length; i++) {
          var event = events[i];
          var when = event.start.dateTime;
          if (!when) {
            when = event.start.date;
          }
          appendTable(event.summary, when);
          //send to servlet
          sendEvent(event.summary, when);
        }
      }
    });
  }
  
  function checkAdding(start, end){
	  if(start>end)return false;
	  else return true;
  }
  
  function createEvent(){
	  var summary = document.getElementById('eTitle').value;
	  var sDate = document.getElementById('eSDate').value;
	  var eDate = document.getElementById('eEDate').value;
	  var sTime = document.getElementById('eSTime').value;
	  var eTime = document.getElementById('eETime').value;
	  
	  if(!checkAdding(sDate+sTime, eDate+eTime)) {
		  console.log("error");
		  var err = document.getElementById('error');
		  var textContent = document.createTextNode("invalide input!" + '\n');
		  err.appendChild(textContent);
		  return null;
	  }
	  
	  var event = {
			  'summary': summary,
			  'start': {
			    'dateTime': sDate+"T"+sTime+":00-07:00"
			  },
			  'end': {
			    'dateTime': eDate+"T"+eTime+":00-07:00"
			  }
	  }
	  document.getElementById('eTitle').value = "Event Title";
	  document.getElementById('eSDate').value = null;
	  document.getElementById('eEDate').value = null;
	  document.getElementById('eSTime').value = null;
	  document.getElementById('eETime').value = null;
	  return event;
	  
  }
  
  function addEvent(){
	  
	  var event = createEvent();
	  var request = gapi.client.calendar.events.insert({
		  'calendarId': 'primary',
		  'resource': event
		});

		request.execute(function(event) {
		});
  }
  function setImg() {
	  
  }