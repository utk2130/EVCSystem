<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.ResultSet" %>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String sql = "SELECT * FROM user";
    PreparedStatement ps = conn.prepareStatement(sql);

    ResultSet rs = ps.executeQuery();
}
catch(Exception e){
    e.printStackTrace();
    response.sendRedirect("error.jsp");
}
%>

<html>

<body>
    <h2>Edit User</h2>

    <form action="update.jsp" method="post">
        <label for="fname">First Name:</label>
        <input type="text" id="fname" name="fname" >

        <label for="lname">Last Name:</label>
        <input type="text" id="lname" name="lname" >

        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required >

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" >

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" >

        <label for="mob_no">Mobile Number:</label>
        <input type="text" id="mob_no" name="mob_no" >

        <input type="hidden" name="id" >

        <input type="submit" value="Update">
    </form>
</body>
</html>
