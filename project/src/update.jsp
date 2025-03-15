<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String uname = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String mob_no = request.getParameter("mob_no");
    String id = request.getParameter("id");

    String sql = "UPDATE user 
                 SET fname=?, lname=?, username=?, password=?, email=?, mob_no=? 
                 WHERE username=?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, fname);
    ps.setString(2, lname);
    ps.setString(3, uname);
    ps.setString(4, password);
    ps.setString(5, email);
    ps.setString(6, mob_no);
    ps.setString(7, uname);

    int rowsAffected = ps.executeUpdate();

    if (rowsAffected > 0) {
        %>
        <script>
            alert("Credentials updated Successfully");
            window.location.href = "userdata.jsp";
        </script>
        <%
    } else {
        %>
        <script>
            alert("Failed to update credentials. Please try again.");
            window.location.href = "edit.jsp";
        </script>
        <%
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