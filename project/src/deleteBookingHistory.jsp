<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@page errorPage="error.jsp"%>

<%
    String id = request.getParameter("id");

    if (id == null || id.trim().equals("")) {
%>
        <script>
            alert("Invalid booking ID.");
            window.location.href = "booking_list.jsp"; 
        </script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

        String sql = "DELETE FROM booking_history WHERE id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, id);

        int rows = ps.executeUpdate();

        if (rows > 0) {
%>
            <script>
                alert("Booking deleted successfully!");
                window.location.href = "adminDashboard.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("Booking ID not found.");
                window.location.href = "adminDashboard.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("Error deleting booking: <%= e.getMessage() %>");
            window.location.href = "adminDashboard.jsp";
        </script>
<%
    } finally {
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
