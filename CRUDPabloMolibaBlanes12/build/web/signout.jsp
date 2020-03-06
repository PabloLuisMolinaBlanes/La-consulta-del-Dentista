<%-- 
    Document   : signout
    Created on : 05-Mar-2020, 20:13:59
    Author     : apolo234
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/consultadeldentista"
,"updator", "updator");
PreparedStatement cookier = con.prepareStatement("SELECT username, cookie FROM cookie WHERE cookie = ?");
cookier.setString(1, request.getRequestedSessionId());
ResultSet chaser = cookier.executeQuery();
if (!chaser.next()) {
String redirectURL = "http://localhost:8080/CRUDPabloMolinaBlanes12/login.html";
response.sendRedirect(redirectURL);
}
PreparedStatement deletor = con.prepareStatement("DELETE FROM cookie WHERE cookie = ?");
deletor.setString(1, request.getRequestedSessionId());
deletor.execute();
String redirectURL = "http://localhost:8080/CRUDPabloMolinaBlanes12/login.html";
response.sendRedirect(redirectURL);
%>
