<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String search = request.getParameter("search");

    String sql = "SELECT * FROM location WHERE location LIKE ?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, "%" + search + "%");
    ResultSet rs = ps.executeQuery();

%>
    <html>
    <body>
        <table border=1 cellspacing=0 cellpadding=10>
            <tr>
                <td>ID</td>
                <td>Name</td>
                <td>Place</td>
                <td>Location</td>
                <td>Book</td>
            </tr>
<%
    while (rs.next()) {
        String id = rs.getString("id");
        String name = rs.getString("name");
        String location = rs.getString("location");
        String maps = rs.getString("map");
%>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= location %></td>
                <td><iframe src="<%= maps %>"></iframe></td>
                <td><input type="button" name="booking" onclick="book('<%= id %>')" value="Book"></td>
            </tr>
<%
    }
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("error.jsp");
}
%>
        </table>
        <script>
            function book(locationId) {
               
                <%
             
                String username = (String) session.getAttribute("uname");

                if (username == null) {
                
                    response.sendRedirect("userlogin.jsp");
                } else {
                   %>
                   window.location.href = "book.jsp?id=" + locationId;
                   <%
                }
                %>

            }
        </script>
    </body>
    </html>
