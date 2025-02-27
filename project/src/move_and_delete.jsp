<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<% 
 try{
    String uname=(String)session.getAttribute("uname");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    int id=(int)request.getParameter("id");
    conn.setAutoCommit(false);
    String sql2="SELECT * FROM bookings WHERE id=?";
    PreparedStatement ps2=conn.prepareStatement(sql2);
    ps2.setInteger(1,id);
    ResultSet rs=ps2.executeQuery();
    if(rs.next()){
        String sql="DELETE FROM bookings WHERE id = ?";
        PreparedStatement ps=conn.prepareStatement(sql);
        ps.setInteger(1,id);
        String vname = rs.getString("v_name");
        String vno = rs.getString("v_no");
        String name = rs.getString("name");
        String email = rs.getString("email");
        String date = rs.getString("booking_date");
        String time = rs.getString("booking_time");
        String mob_no = rs.getString("phone");
        String slot = rs.getString("selected_slot");
        int rows=ps.executeUpdate();

        String sql1="INSERT INTO booking_history(v_name, v_no, name, email, phone, booking_date, booking_time, selected_slot,username) values(?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps1 = conn.prepareStatement(sql1);
            ps1.setString(1, vname);
            ps1.setString(2, vno);
            ps1.setString(3, name);
            ps1.setString(4, email);
            ps1.setString(5, mob_no);
            ps1.setString(6, date);
            ps1.setString(7, time);
            ps1.setString(8, slot);
            ps1.setString(9, uname);
        int rowsAffected=ps1.executeUpdate();

        conn.commit();
        
        %><script> alert("Thanks For confirmation"); 
        window.location.href="index.jsp";
        </script><%
        } else {
%>
            <script>
                alert("No record found with the given ID.");
                window.history.back(); 
            </script>
<%
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