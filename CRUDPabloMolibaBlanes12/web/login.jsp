<%-- 
    Document   : login.jsp
    Created on : 29-Feb-2020, 10:46:46
    Author     : apolo234
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<% 
// My cleanest code so far.    
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/consultadeldentista"
,"updator", "updator");
PreparedStatement stmt = con.prepareStatement("SELECT username, password FROM usuario WHERE username = ? AND password = ?"); 
stmt.setString(1,request.getParameter("username"));
stmt.setString(2,request.getParameter("password"));
ResultSet result = stmt.executeQuery();
if(result.next()) {
PreparedStatement deletor = con.prepareStatement("DELETE FROM cookie WHERE username = ?");
deletor.setString(1, request.getParameter("username"));
deletor.execute();
PreparedStatement cookier = con.prepareStatement("INSERT INTO cookie (username, cookie) VALUES (? , ?)");
cookier.setString(1, request.getParameter("username"));
cookier.setString(2, request.getRequestedSessionId());
cookier.executeUpdate();
String redirectURL = "http://localhost:8080/CRUDPabloMolinaBlanes12/dentistCRUDFront.jsp";
response.sendRedirect(redirectURL);
} else {
String redirectURL = "http://localhost:8080/CRUDPabloMolinaBlanes12/login.html";
response.sendRedirect(redirectURL);   
}
%>