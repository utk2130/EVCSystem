<html>
<link href="./SCSS/addlocation.css" rel="stylesheet">
    <body>
    <form action="addlocation.jsp" method="post">
    <div class="container">
        Enter Name:
        <input type="text" name="place" required>
        Enter Location:
        <input type="text" name="location" required>
        Enter Map:
        <input type="url" name="map" id="" required>
    <div class="b1">
        <input type="submit" name="submit" value="submit" class="button">
        <button type="button" value="View" name="view"><a href="data.jsp" class="view" style="text-decoration: none; font-weight: bold;color: black">View</a></button>
    </div>
    </div>
    </form>
    </body>
</html>

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<%
    String place = request.getParameter("place");
    String location = request.getParameter("location");
    String map = request.getParameter("map");

    if (request.getMethod().equalsIgnoreCase("post")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

            // Using PreparedStatement to prevent SQL injection
            String sql = "INSERT INTO location (name, location, map) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, place);
            ps.setString(2, location);
            ps.setString(3, map);

            // Use executeUpdate for INSERT, UPDATE, DELETE queries
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                %>
                <script>
                    alert("Record Inserted Successfully");
                    window.location.href = "addlocation.jsp";
                </script>
                <%
            } else {
                %>
                <script>
                    alert("Failed to Insert Record");
                    window.location.href = "addlocation.jsp";
                </script>
                <%
            }

            // Close the connection
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
%>


<%-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script> --%>