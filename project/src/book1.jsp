<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@page errorPage="error.jsp"%>

<div id="loading" style="display:none;">
    <img src="./images/loading.gif" alt="Loading..." width="50">
    <p>Redirecting to Payment...</p>
</div>

<%
try{
    String vname = request.getParameter("vname");
    String vno = request.getParameter("vnum");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String date = request.getParameter("date");
    String mob_no = request.getParameter("phone");
    String slot = request.getParameter("slot");

    String uname=(String)session.getAttribute("uname");
    
    String fTime=request.getParameter("fTime");
    String tTime=request.getParameter("tTime");

    if (fTime == null || fTime.isEmpty() || tTime == null || tTime.isEmpty() ) {
        out.println("<p style='color:red;'>Error: Invalid data received.</p>");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String checkSql = "SELECT * FROM bookings WHERE selected_slot = ? AND booking_date = ? AND (f_time BETWEEN ? AND ?  OR t_time BETWEEN ? AND ?)";
    PreparedStatement checkPs = conn.prepareStatement(checkSql);
    checkPs.setString(1, slot);
    checkPs.setString(2, date);
    checkPs.setString(3, fTime);
    checkPs.setString(4, tTime);
    checkPs.setString(5, fTime);
    checkPs.setString(6, tTime);
    ResultSet rs = checkPs.executeQuery();

    // Creating the price session
    String[] fromParts = fTime.split(":");
    String[] toParts = tTime.split(":");

    int h1 = Integer.parseInt(fromParts[0]);
    int m1 = Integer.parseInt(fromParts[1]);
    int h2 = Integer.parseInt(toParts[0]);
    int m2 = Integer.parseInt(toParts[1]);

    int tot_time=(h2 * 60 + m2) - (h1 * 60 + m1);
    int price=tot_time*36;
    // session.setAttribute("price",price);
    
    if (rs != null && rs.next()) {
        String Slot1 = rs.getString("selected_slot");
        String Time1 = rs.getString("f_time");
        String Time2 = rs.getString("t_time");
%>
        <script>
            alert("This Vehicle is already registered for the slot= "+Slot1+". Please try after time "+Time1+" - "+Time2 +".");
            window.location.href = "book.jsp";
        </script>
<%
    } else {
        // If there are no conflicting records, proceed with registration
        String sql = "insert into bookings(v_name, v_no, name, email, phone, booking_date, f_time, t_time, selected_slot,username,amount) values(?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, vname);
        ps.setString(2, vno);
        ps.setString(3, name);
        ps.setString(4, email);
        ps.setString(5, mob_no);
        ps.setString(6, date);
        ps.setString(7, fTime);
        ps.setString(8, tTime);
        ps.setString(9, slot);
        ps.setString(10, uname);
        ps.setString(11, price);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
%>
            <script>
                document.getElementById("loading").style.display = "block";
                alert("REGISTRATION SUCCESSFUL");
                setTimeout(function() {
                    window.location.href = "booking.jsp";
                }, 2000); // 2-second delay
                // window.location.href = "booking.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("Failed to register. Please try again.");
                window.location.href = "book.jsp";
            </script>
<%
        }
    }
}catch(Exception e){
    e.printStackTrace();
    %>
        <script>
            alert("Error: <%= e.getMessage() %>");
        </script>
    <%
}
%>
