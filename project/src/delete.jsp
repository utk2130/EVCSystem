<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String userId = request.getParameter("id");
    String sql = "DELETE FROM user WHERE id=?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, userId);

    int rowsAffected = ps.executeUpdate();

    if (rowsAffected > 0) {
        // Record deleted successfully
        response.sendRedirect("userTable.jsp");
    } else {
        // Handle deletion failure
    }
    
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
