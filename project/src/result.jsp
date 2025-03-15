
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book My Slot</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="./SCSS/result.css" rel="stylesheet">
</head>
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
<body>
<%
        if(rs == null){
        %> <script>
                alert("Can't Find Station in ",<%= search %>);
            </script>
        <%
        }else{
%>
    <div class="container">
        <%@ include file="navbar.jsp" %>
        <section>
            <h2>Book Your Charging Slot</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Place</th>
                    <th>Location</th>
                    <th>Book</th>
                </tr>
            <%
        }
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
                   <td><button class="btn-book" onclick="book('<%= id %>')" >Book</button></td>
                </tr>
            </table>
        </section>
    </div>
    <%
    }
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
