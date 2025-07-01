<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<%
    String id = request.getParameter("id");
    String place = "";
    String location = "";
    String map = "";

    if (id != null && request.getMethod().equalsIgnoreCase("GET")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");
            String sql = "SELECT * FROM location WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                place = rs.getString("name");
                location = rs.getString("location");
                map = rs.getString("map");
            } else {
%>
                <script>
                    alert("Station not found.");
                    window.location.href = "userDashboard.jsp";
                </script>
<%
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String updatedPlace = request.getParameter("place");
        String updatedLocation = request.getParameter("location");
        String updatedMap = request.getParameter("map");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");
            String updateSql = "UPDATE location SET name = ?, location = ?, map = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(updateSql);
            ps.setString(1, updatedPlace);
            ps.setString(2, updatedLocation);
            ps.setString(3, updatedMap);
            ps.setInt(4, Integer.parseInt(id));

            int rowsUpdated = ps.executeUpdate();
            conn.close();

            if (rowsUpdated > 0) {
%>
                <script>
                    alert("Station updated successfully.");
                    window.location.href = "userDashboard.jsp";
                </script>
<%
            } else {
%>
                <script>
                    alert("Failed to update station.");
                    window.location.href = "userDashboard.jsp";
                </script>
<%
            }
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit EV Station</title>
    <link href="./SCSS/addlocation1.css" rel="stylesheet">
</head>
<body>
    <header>
        <%@ include file="adminNav.jsp" %>
    </header>
    <div class="container">
        <h2>Edit EV Station</h2>
        <form action="edit.jsp?id=<%=id%>" method="post">
            <label>Enter Station Name:</label>
            <input type="text" name="place" value="<%=place%>" required>

            <label>Enter Station Location:</label>
            <input type="text" name="location" value="<%=location%>" required>

            <label>Enter Station Map URL:</label>
            <input type="url" name="map" value="<%=map%>" required>

            <div class="b1">
                <input type="submit" name="submit" value="Update" class="button">
                <a href="userDashboard.jsp" class="view">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
