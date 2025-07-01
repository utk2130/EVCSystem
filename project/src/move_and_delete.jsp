<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<% 
    Connection conn =null;
 try{
    String uname=(String)session.getAttribute("uname");
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging", "root", "");

    int id=Integer.valueOf(request.getParameter("id"));
    String payment_id=request.getParameter("payment_id");
    conn.setAutoCommit(false);

    Statement stmt = conn.createStatement();
    stmt.execute("SET innodb_lock_wait_timeout = 5");

    String sql2="SELECT * FROM bookings WHERE id=?";
    PreparedStatement ps2=conn.prepareStatement(sql2);
    ps2.setInt(1,id);
    ResultSet rs=ps2.executeQuery();
    if(rs.next()){
        String sql="DELETE FROM bookings WHERE id = ?";
        PreparedStatement ps=conn.prepareStatement(sql);
        ps.setInt(1,id);
        String vname = rs.getString("v_name");
        String vno = rs.getString("v_no");
        String name = rs.getString("name");
        String email = rs.getString("email");
        String date = rs.getString("booking_date");
        String ftime = rs.getString("f_time");
        String ttime=rs.getString("t_time");
        String mob_no = rs.getString("phone");
        String slot = rs.getString("selected_slot");
        String amount = rs.getString("amount");
        int rows=ps.executeUpdate();

        String sql1="INSERT INTO booking_history(v_name, v_no, name, email, phone, booking_date, f_time, t_time, selected_slot,username,amount) values(?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps1 = conn.prepareStatement(sql1);
            ps1.setString(1, vname);
            ps1.setString(2, vno);
            ps1.setString(3, name);
            ps1.setString(4, email);
            ps1.setString(5, mob_no);
            ps1.setString(6, date);
            ps1.setString(7, ftime);
            ps1.setString(8, ttime);
            ps1.setString(9, slot);
            ps1.setString(10, uname);
            ps1.setString(11, amount);
        int rowsAffected=ps1.executeUpdate();

        conn.commit();
        
        %><script> alert("Thanks For confirmation"); 
        window.location.href="report.jsp?id=<%=id%>&payment_id=<%=payment_id%>";
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
    if (conn != null) {
        try {
            conn.rollback(); // important!
        } catch(SQLException se){
            se.printStackTrace();
        }
    }

    e.printStackTrace();
%>
        <script>
            alert("Error: <%= e.getMessage() %>");
        </script>
<%
 }

 %>