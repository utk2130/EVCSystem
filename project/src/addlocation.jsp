<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Location</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="./SCSS/addlocation1.css" rel="stylesheet">
</head>
<body>
<header>
    <%@ include file="adminNav.jsp" %>
</header>
    <div class="container">
        <h2>Add EV Station</h2>
        <form action="addlocation.jsp" method="post">
            <label>Enter Station Name:</label>
            <input type="text" name="place" placeholder="Enter place name" required>
            
            <label>Enter Station Location:</label>
            <input type="text" name="location" placeholder="Enter location" required>
            
            <label>Enter Station Map URL:</label>
            <input type="url" name="map" placeholder="Enter map link" required>
            
            <div class="b1">
                <input type="submit" name="submit" value="Submit" class="button">
                <a href="data.jsp" class="view">View</a>
            </div>
        </form>
    </div>
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
        %>
            <script>
                alert("Error: <%= e.getMessage() %>");
            </script>
        <%
        }
    }
%>


<%-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script> --%>