<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electric Car Charging - Reservations</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="./SCSS/bookingReport.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <%@ include file="navbar.jsp" %>
<%
    try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    String sql="SELECT * FROM bookings WHERE username = ?";
    PreparedStatement ps=conn.prepareStatement(sql);
    ps.setString(1,uname);
    ResultSet rs=ps.executeQuery();
%>
        <section>
            <h2>Reservation Details</h2>
            <table>
                <tr>
                    <th>Vehicle</th>
                    <th>Vehicle No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Mobile No</th>
                    <th>Slot</th>
                    <th>Status</th>
                </tr>
    <%
    while(rs.next()){
        int id=rs.getInteger("id");
        String vname = rs.getString("v_name");
        String vno = rs.getString("v_no");
        String name = rs.getString("name");
        String email = rs.getString("email");
        String date = rs.getString("booking_date");
        String time = rs.getString("booking_time");
        String mob_no = rs.getString("phone");
        String slot = rs.getString("selected_slot");
    %>
        <tr class="data">
        <td><%= vname %> </td>
        <td><%= vno %> </td>
        <td><%= name %> </td>
        <td><%= email %> </td>
        <td><%= date %> </td>
        <td><%= time %> </td>
        <td><%= mob_no %> </td>
        <td><%= slot %> </td>
        <td><button class="btn-status confirmed" onclick="deleteAndMove('<%= vno %>')" >Confirmed</button></td>
        </tr>
  <%
    }%>
            </table>
        </section>
    </div>
    <%
    conn.close();
    }catch(Exception e){
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    }
%>

<script>
    function deleteAndMove(id) {
        if (confirm("Are you sure you want to move and delete this record?")) {
            window.location.href = "move_and_delete.jsp?id=" + id;
        }
    }
</script>
</body>
</html>
