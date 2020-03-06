<%-- 
    Document   : AddDataDB
    Created on : 02-Mar-2020, 09:09:44
    Author     : apolo234
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
        <title>Add</title>
        <%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="org.owasp.html.HtmlPolicyBuilder"%>
<%@ page import="org.owasp.html.PolicyFactory"%>
<%@ page import="org.owasp.html.Sanitizers"%>
    </head>
    <body>
        <h1>Add the new row.</h1>
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
            String dbname = request.getParameter("dbname");
            // This little code checks if some tech-savier person tries to put in 'usuario' in my hidden dbname input, so that it doesn't execute querying code (with all passwords!).
            if (dbname.equals("usuario")) {
                out.println("<p>Only the admininstrators of the server can add data to the table usuarios, you have to login as the admininstrator before making adding users or querying this database, if you need it, refer to your admininstrator.</p>");
                out.println("<p>Warning, to all possible intruders, all database modifications in Users are throughfully recorded in the server, <strong>do not proceed if you are not an authorized user</strong>. Prosecution and legal claims may proceed.</p>");
                out.println("<a href='/CRUDPabloMolinaBlanes12/chooseDBAddUsuarioMain.jsp'>Proceed</a>");
            } else {
                // The first part is code which finds the PK for each table, it should work as long as there is just one PK column in the table, it would surprise me if it worked with more columns, tbh.
                PreparedStatement table = con.prepareStatement("SHOW KEYS FROM " + dbname + " WHERE Key_name = 'PRIMARY'");
                    ResultSet rowCoun = table.executeQuery();
                    rowCoun.next();
                    String pk = rowCoun.getString("Column_name");
                    PreparedStatement pks = con.prepareStatement("SELECT ? FROM " + dbname);
                    pks.setString(1, pk);
                    ResultSet definitepks = pks.executeQuery();
                    ResultSetMetaData pkspks = pks.getMetaData();
                    definitepks.next();
                    String query = "SELECT * FROM " + dbname;
                    PreparedStatement usuarios = con.prepareStatement(query);
            ResultSet users = usuarios.executeQuery();            
            ResultSetMetaData md = usuarios.getMetaData();
            // Magic query time, this basically checks if you have stated you want to perform the action.
                if (request.getParameter("iamthemagicbutton") == null) {
               } else {
                   if (request.getParameter("iamthemagicbutton").equals("yesmakeit")) {
                    // Aah, dynamically-generated queries for previously unknown databases, surprsisingly, this started working faster than I expected.
                    String comb = "INSERT INTO " + dbname + " (";
                    int columnCount = 1;
                    int count = md.getColumnCount();
                    while (columnCount <= count-1) {
                        
                            comb += md.getColumnName(columnCount) + ", ";
                        
                        columnCount++;
                    }
                    //columnCount++;
                    comb += md.getColumnName(columnCount);
                    comb += ") VALUES (";
                    columnCount = 1;
                    while (columnCount <= count-1) {
                        
                            comb += "?, ";
                        
                        columnCount++;
                    }
                    //columnCount++;
                    comb += "?)";
                    PreparedStatement deletion = con.prepareStatement(comb);
                    columnCount = 1;
                    while (columnCount <= count) {
                          if (request.getParameter(md.getColumnName(columnCount)).equals("")) {
                              deletion.setString(columnCount, null);
                          } else {
                              deletion.setString(columnCount, request.getParameter(md.getColumnName(columnCount)));
                          }
                        columnCount++;
                    }
                    deletion.execute();
                    out.println("<p>Your addition was succesful!</p>");
                   }
                }
            // Sanitizer tested, it should not have trouble with any non-malicious and typical outputs.
            PolicyFactory sanitizer = Sanitizers.FORMATTING.and(Sanitizers.BLOCKS);
            out.println("<table>");
            int count = md.getColumnCount();
            out.print("<tr>");
            for (int i=1; i<=count; i++) {
            out.print("<th>");
            out.print(md.getColumnName(i));
            out.print("</th>");
            }
             out.println("</tr>");
             int counter = 1;
             // There are some useless inputs down here, such as the row.
             while (users.next()) {
                 counter = 1;
                 out.println("<form action='AddDataDB.jsp' method='POST'>");
                 out.println("<br>" + "<tr>"); 
                 while (counter <= count) {
                     String currentData = sanitizer.sanitize(users.getString(md.getColumnName(counter)));
                     out.println("<td>" + "<input type='" + "text" + "' value='"  + currentData + "' name='" + md.getColumnName(counter) + "'" + ">" + "</td>" );
                     counter++;
                 }
                 out.println("<td><input type='submit' name='iamthemagicbutton' value='yesmakeit' onclick='setter(" + counter + ")'></td>");
                 out.println("<input type='hidden' name'dbname' value='" + dbname + "'>");
                 out.println("</form>");
                 out.println("<input type='hidden' name='row' value='" + md.getColumnName(1) + "'>");

             }
             counter = 1;
             out.println("<form action='AddDataDB.jsp' method='POST'>");
             out.println("<br>" + "<tr>");
             while (counter <= count) {
             out.println("<td>" + "<input type='" + "text" + "' value='" + "' name='" + md.getColumnName(counter) + "'" + ">" + "</td>" );
             counter++;
             }
             out.println("<td><input type='submit' name='iamthemagicbutton' value='yesmakeit' onclick='setter(" + counter + ")'></td>");
             out.println("</tr>");
             out.println("</table>");
             out.println("<input type='hidden' name='row' value='" + md.getColumnName(1) + "'>");
             out.println("<input type='hidden' name='dbname' value='" + dbname + "'>");
             out.println("</form>");
             con.close();
            }
        %>
    </body>
</html>
