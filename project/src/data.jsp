<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book My Slot- Reservations</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="./SCSS/bookingReport.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <%@ include file="adminNav.jsp" %>
<%
    try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String sql = "SELECT * FROM location";
    PreparedStatement ps = conn.prepareStatement(sql);

    ResultSet rs = ps.executeQuery();

%>
        <section>
            <h2>EV Station Details</h2>
            <table>
                <tr>
                    <th>id</th>
                    <th>Name</th>
                    <th>Place</th>
                    <th>Location</th>
                    <th>Edit</th>
                </tr>
    <%
    while(rs.next()){
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
            <td><button class="btn-status confirmed" onclick="edit('<%= id %>')" >Edit</button></td>
        </tr>
        </tr>
  <%
    }%>
            </table>
        </section>
    </div>
    <%
    conn.close();
    }catch(Exception e){
        e.printStackTrace();
        %>
            <script>
                alert("Error: <%= e.getMessage() %>");
            </script>
        <%
    }
%>

<script>
    function edit(id) {
        if (confirm("Are you sure you want to move and delete this record?")) {
            window.location.href = "#jsp?id=" + id;
        }
    }
</script>
</body>
</html>































<%-- <%@ page import="java.sql.*" %>
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
%> --%>
