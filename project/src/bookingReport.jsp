<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book My Slot- Reservations</title>
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
                    <th>Payment</th>
                </tr>
    <%
    while(rs.next()){
        String id = rs.getString("id");
        String vname = rs.getString("v_name");
        String vno = rs.getString("v_no");
        String name = rs.getString("name");
        String email = rs.getString("email");
        String date = rs.getString("booking_date");
        String time = rs.getString("f_time")+" TO "+rs.getString("t_time");
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
        <td><button class="btn-status confirmed" onclick="deleteAndMove('<%= id %>')" >Confirmed</button></td>
        <td><button class="btn-status confirmed" onclick='redirectToPayment()' >Pay</button></td>
        </tr>
  <%
    }%>
            </table>
        </section>
        <div id="loading" style="display:none; position: absolute;">
            <img src="./images/loading.gif" alt="Loading..." width="50">
            <p>Redirecting to Payment...</p>
        </div>
    </div>
    <%
    conn.close();
    }catch(Exception e){
        e.printStackTrace();
        %>
            <script>
                alert("Error: <%= e.getMessage() %>");
            </script>
        <%
    }
%>

<script>
    function deleteAndMove(id) {
        if (confirm("Are you sure you want to move and delete this record?")) {
            window.location.href = "move_and_delete.jsp?id=" + id;
        }
    }

    function showLoading() {
        document.getElementById("loading").style.display = "block";
    }

    function redirectToPayment() {
        showLoading(); // Show loading animation
        setTimeout(function() {
            window.location.href = "booking.jsp";
        }, 2000);
    }

</script>
</body>
</html>
