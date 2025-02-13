<html>
<head> <title> REGISTRATION FORM </title> </head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@page errorPage="error.jsp"%>
 <%
 String fname=request.getParameter("firstName");
 String lname=request.getParameter("lastName");
 String uname=request.getParameter("username");
 String email=request.getParameter("emailAddress");
 String password=request.getParameter("password");
 String mob_no=request.getParameter("phoneNumber");

 Class.forName("com.mysql.cj.jdbc.Driver");
 Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/evcharging","root","");
 
 Statement st=conn.createStatement();

  String sql="select * from user where username=?";
  PreparedStatement ps;
  ps = conn.prepareStatement(sql);
  ps.setString(1,uname);

  ResultSet rs= ps.executeQuery();
  
	if(rs.next()){
	  String user=rs.getString("username");
	  if(uname.equals(user)){
%>	    <script>
      			alert("This Username is already registered");
      			window.location.href="registration.html";
    		</script>
<%    	}
	}
	else{
		int i=st.executeUpdate("insert into user(fname,lname,username,password,email,mob_no) values('"+fname+"','"+lname+"','"+uname+"','"+password+"','"+email+"','"+mob_no+"')");
		// ps.setString(1,fname);
		// ps.setString(2,lname);
		// ps.setString(3,uname);
		// ps.setString(4,password);
		// ps.setString(5,email);
		// ps.setString(6,mob_no);
%>	    <script>
      		alert("REGISTRATION SUCCESSFULL");
      		window.location.href="userlogin.jsp";
    	</script>
<%
}
%>
</body>
</html>