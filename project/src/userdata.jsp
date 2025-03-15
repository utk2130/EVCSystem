<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String sql = "SELECT * FROM user";
    PreparedStatement ps = conn.prepareStatement(sql);

    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Table</title>
</head>
<body>
    <table border="1" cellspacing="0" cellpadding="10">
        <tr>
            <td>ID</td>
            <td>First Name</td>
            <td>Last Name</td>
            <td>Username</td>
            <td>Password</td>
            <td>Email</td>
            <td>Mobile Number</td>
            <td>Edit</td>
            <td>Delete</td>
        </tr>

        <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString("id") %></td>
                <td><%= rs.getString("fname") %></td>
                <td><%= rs.getString("lname") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("password") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("mob_no") %></td>
                <td><a href="edit.jsp?id=<%= rs.getString("id") %>">Edit</a></td>
                <td><a href="delete.jsp?id=<%= rs.getString("id") %>">Delete</a></td>
            </tr>
        <% } %>
    </table>
</body>
</html>

<%
    // Don't forget to close the connection
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
    %>
        <script>
            alert("Error: <%= e.getMessage() %>");
        </script>
    <%
}
%>
