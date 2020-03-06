<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="org.owasp.html.HtmlPolicyBuilder"%>
<%@ page import="org.owasp.html.PolicyFactory"%>
<%@ page import="org.owasp.html.Sanitizers"%>
<html>
    <head>
        <script>
        function setter(number) {
        var elements = document.getElementsByClassName("root");
        for (var c = 0; c < elements.length; c++) {
        if (elements[c].value = number) {
         elements[c].value = document.getElementById("rootvalue").value;
        }
       }
      }
        </script>
        <meta charset="UTF-8">
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">     <!-- Tres enlaces con librerias de JS de Bootstrap -->
   <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
     <link rel="stylesheet" href="login.css">
     <link rel="stylesheet" href="dentistCRUD.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modify</title>
    </head>
    <body>
         <% Class.forName("com.mysql.jdbc.Driver");
               Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/consultadeldentista"
               ,"updator", "updator");
               PreparedStatement cookier = con.prepareStatement("SELECT username, cookie FROM cookie WHERE cookie = ?");
cookier.setString(1, request.getRequestedSessionId());
ResultSet chaser = cookier.executeQuery();
if (!chaser.next()) {
String redirectURL = "http://localhost:8080/CRUDPabloMolinaBlanes12/login.html";
response.sendRedirect(redirectURL);
}
               PreparedStatement stmt = con.prepareStatement("SELECT password FROM usuario WHERE userID = 1 AND password = ?"); 
               stmt.setString(1,request.getParameter("rootpassword"));
               ResultSet result = stmt.executeQuery();
               String res = "";
               int count = 1;
               if(result.next()) {
                   if (request.getParameter("iamthemagicbutton") == null) {
               } else {
                   if (request.getParameter("iamthemagicbutton").equals("yesmakeit")) {
                    PreparedStatement modify = con.prepareStatement("UPDATE Usuario SET username = ?, email = ?, password = ?, dateOfCreation = ?, userID = ? WHERE userID = ?"); 
                    modify.setString(1, request.getParameter("username"));
                    modify.setString(2, request.getParameter("email"));
                    modify.setString(3, request.getParameter("password"));
                    modify.setString(4, request.getParameter("dateOfCreation"));
                    modify.setString(5, request.getParameter("pk"));
                    modify.setString(6, request.getParameter("row"));
                    modify.execute();
                    out.println("<p>Your information has been sent succesfully!</p>");
                   } else {
                   }
               }
                   boolean loggedIn = true;
                   PreparedStatement usuarios = con.prepareStatement("SELECT * FROM usuario");
                   ResultSet users = usuarios.executeQuery();
                   ResultSetMetaData md = usuarios.getMetaData();
                   count = 0;
                   while (users.next()) {
                       count++;
                   }
                   res = "Confirmed access";
               } else {
                   res = "Invalid password!";
               } 
         con.close();%>
        <form action="chooseDBModifyUsuarioMain.jsp" method="POST">
            <h1>Input the admin password, please</h1>
            <input type="password" id="rootvalue" name="rootpassword">
            <input type="submit">
            <p><%= res %></p>
        </form>
        <%  
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/consultadeldentista"
               ,"updator", "updator");
            int counter = 1;
               stmt = con.prepareStatement("SELECT password FROM usuario WHERE userID = 1 AND password = ?"); 
               stmt.setString(1,request.getParameter("rootpassword"));
               result = stmt.executeQuery();
               if(result.next()) {
            PreparedStatement usuarios = con.prepareStatement("SELECT * FROM usuario");
            ResultSet users = usuarios.executeQuery();
            ResultSetMetaData md = usuarios.getMetaData();
            PolicyFactory sanitizer = Sanitizers.FORMATTING.and(Sanitizers.BLOCKS);
            out.println("<table>");
            count = md.getColumnCount();
            out.print("<tr>");
            for (int i=1; i<=count; i++) {
            out.print("<th>");
            out.print(md.getColumnName(i));
            out.print("</th>");
            }
             out.println("</tr>");
             while (users.next()) {
            String username = sanitizer.sanitize(users.getString("username"));
            String email = sanitizer.sanitize(users.getString("email"));
            out.println("<form action='chooseDBModifyUsuarioMain.jsp' method='POST'>");   
            out.println("<tr>" + "<br>" + "<td>" + "<input type='" + "text" + "' value='"  + username + "' name='" + "username'" + ">" + "</td>" + "<td>" + "<input type='" + "text" + "' value='"  + email + "' name='" + "email'" + ">" + "</td>" + "<td>" + "<input type='" + "password" + "' value='"  + users.getString("password") + "' name='" + "password'" + ">" + "</td>" + "<td>" + "<input type='" + "text" + "' value='"  + users.getString("dateOfCreation") + "' name='" + "dateOfCreation'" + ">" + "</td>" + "<td>" + "<input type='" + "text" + "' value='"  + users.getString("userID") + "' name='" + "pk'" + ">");    
            out.println("<input type='submit' name='iamthemagicbutton' value='yesmakeit' onclick='setter(" + counter + ")'>");
            out.println("<input type='hidden' name='row' value='" + users.getString("userID") + "'>");
            out.println("<input type='hidden' class='root' name='rootpassword' value='" + counter + "'>");
            out.println("</form>");
            counter++;
            %>             
            <%
            
            
            }
            out.println("</table>");
            out.println("<br><br>");
            con.close();
        } %>
    </body>
</html>
