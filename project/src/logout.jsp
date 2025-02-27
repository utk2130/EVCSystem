<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page errorPage="error.jsp" %>

<% 
    if(session.getAttribute("uname") != null){
        session.invalidate();
    %>
    <script>
     alert("Logged out Successfully!");
     window.location.href = "index.jsp";
     </script>
    <%
        // response.sendRedirect("index.html");
    }
%>