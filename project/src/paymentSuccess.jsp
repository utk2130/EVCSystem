<%@ page import="java.sql.*" %>
<% 
    String payment_id = request.getParameter("payment_id");
    String vid=request.getParameter("vid");
    String uname1=(String) session.getAttribute("uname");
    if (payment_id != null) {
        Connection connection = null;
        PreparedStatement pres=null ,pres1 = null;
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

            String sqlStr1="SELECT amount FROM bookings WHERE id = ?";
            pres1=connection.prepareStatement(sqlStr1);
            pres1.setString(1,vid);
            ResultSet resultSet=pres1.executeQuery();
           int amount = 0;
            if (resultSet.next()) {
                amount = Integer.parseInt(resultSet.getString("amount"));
            } else {
            %>
                <script>
                    alert("No booking found for the given ID.");
                    window.location.href = "index.jsp";
                </script>
            <%
                return; // stop further execution
            }
            // Insert payment record
            String sqlStr = "INSERT INTO payments (payment_id, amount, status, uname,v_id) VALUES (?, ?, ?, ?, ?)";
            pres = connection.prepareStatement(sqlStr);
            pres.setString(1, payment_id);
            pres.setInt(2, amount); // Example amount
            pres.setString(3, "Paid");
            pres.setString(4, uname1);
            pres.setString(5,vid);
            int rowsp=pres.executeUpdate();
            if (rowsp>0){
            session.removeAttribute("vnum");
            %>
            <script>
            alert("Payment Successful!");
            window.location.href = "move_and_delete.jsp?id=<%=vid%>&payment_id=<%=payment_id%>";
            // window.location.href = "report.jsp?id=<%=vid%>&payment_id=<%=payment_id%>";
            </script>
            <%
            }
        } catch(Exception e){
        e.printStackTrace();
        %>
            <script>
                alert("Error: <%= e.getMessage() %>");
            </script>
        <%
    } finally {
            if (pres != null) pres.close();
            if (pres1 != null) pres1.close();
            if (connection != null) connection.close();
        }
    } else {
        out.println("<h2>Invalid Payment!</h2>");
    }
%>
