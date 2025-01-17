<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@page errorPage="error.jsp"%>
<%
    String vname = request.getParameter("vname");
    String vno = request.getParameter("vnum");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    String mob_no = request.getParameter("phone");
    String slot = request.getParameter("slot");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String checkSql = "select * from bookings where selected_slot = ? and booking_time = ?";
    PreparedStatement checkPs = conn.prepareStatement(checkSql);
    checkPs.setString(1, slot);
    checkPs.setString(2, time);
    ResultSet rs = checkPs.executeQuery();

    if (rs != null && rs.next()) {
        String Slot1 = rs.getString("selected_slot");
        String Time = rs.getString("booking_time");
        int id=rs.getInt("id");
        if (slot.equals(Slot1) && time.equals(Time)) {
%>
            <script>
                alert("This Vehicle Number is already registered for the selected slot and time.");
                window.location.href = "book.jsp";
            </script>
<%
        } else {
            // If the slot and time are available, proceed with registration
            String sql = "insert into bookings(v_name, v_no, name, email, phone, booking_date, booking_time, selected_slot) values(?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, vname);
            ps.setString(2, vno);
            ps.setString(3, name);
            ps.setString(4, email);
            ps.setString(5, mob_no);
            ps.setString(6, date);
            ps.setString(7, time);
            ps.setString(8, slot);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
%>
                <script>
                    alert("REGISTRATION SUCCESSFUL");
                    window.location.href = "booking.jsp";
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
    } else {
        // If there are no conflicting records, proceed with registration
        String sql = "insert into bookings(v_name, v_no, name, email, phone, booking_date, booking_time, selected_slot) values(?,?,?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, vname);
        ps.setString(2, vno);
        ps.setString(3, name);
        ps.setString(4, email);
        ps.setString(5, mob_no);
        ps.setString(6, date);
        ps.setString(7, time);
        ps.setString(8, slot);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
%>
            <script>
                alert("REGISTRATION SUCCESSFUL");
                window.location.href = "booking.jsp";
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
%>
