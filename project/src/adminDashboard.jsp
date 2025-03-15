<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background: #1e0342;
            color: white;
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            background: #38075c;
            padding-top: 20px;
        }
        .sidebar a {
            padding: 15px;
            text-decoration: none;
            display: block;
            color: white;
            font-weight: bold;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background: #ff0080;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="adminNav.jsp" %>
    <div class="sidebar">
        <h3 class="text-center">Admin Panel</h3>
        <a href="#users">User Management</a>
        <a href="#stations">EV Station Management</a>
        <a href="#bookings">Booking Management</a>
    </div>

    <div class="content">
        <h2>Admin Dashboard</h2>
        <section id="users">
            <h3>User Management</h3>
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Mobile No</th>
                        <th>Actions</th>
                    </tr>
                </thead>
<%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");
        String usersql="SELECT * FROM user ORDER BY id DESC LIMIT 10";
        PreparedStatement userps=conn.prepareStatement(usersql);
        ResultSet userrs=userps.executeQuery();

        while(userrs.next()){
            String id=userrs.getString("id");
            String username=userrs.getString("username");
            String name=userrs.getString("fname")+" "+userrs.getString("lname");
            String email=userrs.getString("email");
            String mob_no=userrs.getString("mob_no");
%>
                <tbody>
                    <tr>
                        <td><%= id %></td>
                        <td><%= username %></td>
                        <td><%= name %></td>
                        <td><%= email %></td>
                        <td><%= mob_no %></td>
                        <td>
                            <button class="btn btn-warning">Edit</button>
                            <button class="btn btn-danger">Delete</button>
                        </td>
                    </tr>
                </tbody>
     <%   } %>
            </table>
        </section>

        <section id="stations">
            <h3>EV Station Management</h3>
            <button class="btn btn-success">Add Station</button>
            <table class="table table-dark table-striped mt-2">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Location</th>
                        <th>Map</th>
                        <th>Actions</th>
                    </tr>
                </thead>
            <%
                String stationsql="SELECT * FROM location ORDER BY id DESC LIMIT 10";
                PreparedStatement stationps=conn.prepareStatement(stationsql);
                ResultSet stationrs=stationps.executeQuery();
                while(stationrs.next()){
                    String s_id=stationrs.getString("id");
                    String s_name=stationrs.getString("name");
                    String s_location=stationrs.getString("location");
                    String s_map=stationrs.getString("map");
            %>
                <tbody>
                    <tr>
                        <td><%= s_id %></td>
                        <td><%= s_name %></td>
                        <td><%= s_location %></td>
                        <td><%= s_map %></td>
                        <td>
                            <button class="btn btn-warning">Edit</button>
                            <button class="btn btn-danger">Delete</button>
                        </td>
                    </tr>
                </tbody>
            <%  } %>
            </table>
        </section>

        <section id="bookings">
            <h3>Booking Management</h3>
            <table class="table table-dark table-striped">
                <thead>
                    <tr>
                        <th>Vehicle</th>
                        <th>Vehicle No</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Mobile No</th>
                        <th>Slot</th>
                        <th>Actions</th>
                    </tr>
                </thead>
            <%
                String bookSql="SELECT * FROM bookings ORDER BY id DESC LIMIT 10";
                PreparedStatement bookPs=conn.prepareStatement(bookSql);
                ResultSet bookrs=bookPs.executeQuery();
                while(bookrs.next()){
                    String b_id = bookrs.getString("id");
                    String b_vname = bookrs.getString("v_name");
                    String b_vno = bookrs.getString("v_no");
                    String b_name = bookrs.getString("name");
                    String b_email = bookrs.getString("email");
                    String b_date = bookrs.getString("booking_date");
                    String b_time = bookrs.getString("booking_time");
                    String b_mob_no = bookrs.getString("phone");
                    String b_slot = bookrs.getString("selected_slot");
            %>
                <tbody>
                    <tr>
                        <td><%= b_vname %> </td>
                        <td><%= b_vno %> </td>
                        <td><%= b_name %> </td>
                        <td><%= b_email %> </td>
                        <td><%= b_date %> </td>
                        <td><%= b_time %> </td>
                        <td><%= b_mob_no %> </td>
                        <td><%= b_slot %> </td>
                        <td>
                            <button class="btn btn-success">Approve</button>
                            <button class="btn btn-danger">Cancel</button>
                        </td>
                    </tr>
                </tbody>
            <%  } %>
            </table>
        </section>
<%  conn.close();
     }catch(Exception e){
        e.printStackTrace();
        %>
            <script>
                alert("Error: <%= e.getMessage() %>");
            </script>
        <%
    } %>
    </div>
</body>
</html>
