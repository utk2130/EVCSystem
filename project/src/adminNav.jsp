
<% String admin=(String)session.getAttribute("admin"); %>
<link href="./SCSS/navbar.css" rel="stylesheet">
<nav class="navbar">
   <div class="logo"><img src="./images/logo2.png" height="90px" /></div>
   <div>
       <a href="index.jsp">Home</a>
       <a href="adminDashboard.jsp">Dashboard</a>
       <a href="bookingReport.jsp">Bookings</a>
       <a href="adminlogin.jsp">Admin</a>
       <% if(admin == null){ %>
           <a href="userlogin.jsp">Log In</a>
       <% }else{ %>
           <a href="logout.jsp" style="text-decoration: none">Log Out</a>
       <% } %>
   </div>
 </nav>

