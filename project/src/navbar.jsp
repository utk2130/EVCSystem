
<% String uname=(String)session.getAttribute("uname"); %>
<link href="./SCSS/navbar.css" rel="stylesheet">
<nav class="navbar">
   <div class="logo"><img src="./images/logo2.png" height="90px" /></div>
   <div>
       <a href="index.jsp">Home</a>
       <a href="about.jsp">About</a>
       <a href="bookingReport.jsp">Bookings</a>
       <a href="adminlogin.jsp">Admin</a>
       <% if(uname == null){ %>
           <a href="userlogin.jsp">Log In</a>
       <% }else{ %>
           <a href="logout.jsp" style="text-decoration: none">Log Out</a>
       <% } %>
   </div>
 </nav>

