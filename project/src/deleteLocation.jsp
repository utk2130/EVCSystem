<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<%
    String id = request.getParameter("id");

    if (id == null || id.trim().isEmpty()) {
%>
    <script>
        alert("Invalid location ID.");
        window.location.href = "userDashboard.jsp"; 
    </script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

        String sql = "DELETE FROM location WHERE id = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(id));

        int rowsDeleted = ps.executeUpdate();

        if (rowsDeleted > 0) {
%>
    <script>
        alert("Location deleted successfully.");
        window.location.href = "userDashboard.jsp";
    </script>
<%
        } else {
%>
    <script>
        alert("Location ID not found or already deleted.");
        window.location.href = "userDashboard.jsp";
    </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("Error: <%= e.getMessage() %>");
        window.location.href = "userDashboard.jsp";
    </script>
<%
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
