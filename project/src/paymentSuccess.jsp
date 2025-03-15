<%@ page import="java.sql.*" %>
<%
    String payment_id = request.getParameter("payment_id");

    if (payment_id != null) {
        // Database connection
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

            // Insert payment record
            String sql = "INSERT INTO payments (payment_id, amount, status) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, payment_id);
            ps.setDouble(2, 500); // Example amount
            ps.setString(3, "Success");
            ps.executeUpdate();

            out.println("<h2>Payment Successful!</h2>");
            out.println("<p>Payment ID: " + payment_id + "</p>");
            
        } catch (Exception e) {
            out.println("<h2>Payment Failed!</h2>");
            e.printStackTrace();
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    } else {
        out.println("<h2>Invalid Payment!</h2>");
    }
%>
