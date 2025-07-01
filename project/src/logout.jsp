<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<% 
try{
    if(session.getAttribute("uname") != null || session.getAttribute("admin") != null){
        session.invalidate();
    %>
    <script>
     alert("Logged out Successfully!");
     window.location.href = "index.jsp";
     </script>
    <%
        // response.sendRedirect("index.html");
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