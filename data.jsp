<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String sql = "SELECT * FROM location";
    PreparedStatement ps = conn.prepareStatement(sql);

    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        String id = rs.getString("id");
        String name = rs.getString("name");
        String location = rs.getString("location");
        String maps = rs.getString("map");
%>
        <html>
        <body>
            <table border=1 cellspacing=0 cellpadding=10>
                <tr>
                    <td>id</td>
                    <td>Name</td>
                    <td>Place</td>
                    <td>location</td>
                    <td>Book</td>
                </tr>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= location %></td>
                    <td><iframe src="<%= maps %>"></iframe></td>
                    <td><input type="button" name="booking" value="Book"></td>
                </tr>
            </table>
        </body>
        </html>
<%
    }
    // Don't forget to close the connection
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("error.jsp");
}
%>
