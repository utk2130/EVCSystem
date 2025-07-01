<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<% 
    String id = "", fname = "", lname = "", username = "", email = "", mob_no = "", password = "";
    try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging","root","");


    String userId=request.getParameter("id");
    String sql="SELECT * FROM user where id = ?";
    PreparedStatement ps=conn.prepareStatement(sql);
    ps.setString(1,userId);
    ResultSet rs = ps.executeQuery();

    
    if (rs.next()) {
        id = rs.getString("id");
        fname = rs.getString("fname");
        lname = rs.getString("lname");
        username = rs.getString("username");
        password = rs.getString("password");
        email = rs.getString("email");
        mob_no = rs.getString("mob_no");
    } else {
        %>
        <script>
            alert("No user found with the given ID.");
            window.history.back();
        </script>
        <%
        return; 
    }

    }catch(Exception e){
        e.printStackTrace();
        %>
            <script>
                alert("Error: <%= e.getMessage() %>");
            </script>
        <%
    } 
%>
<html>
<link href="./SCSS/edit_user.css" rel="stylesheet">
<body>
    <%@ include file="adminNav.jsp" %>
    <div class="container card-body">
        <div class="vh-100">
        <h2>Edit User</h2>
        <form action="update.jsp" method="post">
            <label for="fname">First Name:</label>
            <input type="text" id="fname" name="fname" value="<%= fname %>" >
            
            <label for="lname">Last Name:</label>
            <input type="text" id="lname" name="lname" value="<%= lname %>" >
            
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="<%= username %>" readonly>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" value="<%= password %>">
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= email %>" >
            
            <label for="mob_no">Mobile Number:</label>
            <input type="text" id="mob_no" name="mob_no" value="<%= mob_no %>" >
            
            <input type="hidden" name="id" value="<%= id %>">
            
            <input type="submit" class="button" value="Update">
        </form>
    </div>
</div>
</body>
</html>
