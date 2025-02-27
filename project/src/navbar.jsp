
<% String uname=(String)session.getAttribute("uname"); %>
<link href="./SCSS/navbar.css" rel="stylesheet">
<nav class="navbar">
   <div class="logo"><img src="./images/logo2.png" height="90px" /></div>
   <div>
       <a href="index.jsp">Home</a>
       <a href="#">About</a>
       <a href="bookingReport.jsp">Bookings</a>
       <a href="adminlogin.jsp">Admin</a>
       <% if(uname == null){ %>
           <a href="userlogin.jsp">Log In</a>
       <% }else{ %>
           <a href="logout.jsp" style="text-decoration: none">Log Out</a>
       <% } %>
   </div>
 </nav>

















































<!-- <link href="homepage.css" rel="stylesheet">

<div class="nav">
        <nav class="navbar">
         <ul class="items">
            <li><a href="userlogin.jsp" >Login</a></li>
            <li><a href="adminlogin.jsp">Admin</a></li>
            <li><a href="homepage.html">Homepage</a></li>
         </ul>
        </nav>
    </div> -->