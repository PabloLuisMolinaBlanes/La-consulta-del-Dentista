<%-- 
    Document   : chooseDBModify
    Created on : 02-Mar-2020, 09:04:04
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
        <title>Modify</title>
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
        <% // Possibly the toughest in terms of Java coding for the CRUD, as I have to combine techniques (find the row I want, and change all values), although it saves JS (thank god).
           // The variable names are misleading here, I should prob change them.
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
            if (dbname.equals("usuario")) {
                out.println("<p>Rows can only be modified by the admininstrators of the server, you have to login as the admininstrator before modifying any rows or querying this database.</p>");
                out.println("<p>Warning, to all possible intruders, all database modifications in Users are throughfully recorded in the server, <strong>do not proceed if you are not an authorized user</strong>. Prosecution and legal claims may proceed.</p>");
                out.println("<a href='/CRUDPabloMolinaBlanes12/chooseDBModifyUsuarioMain.jsp'>Proceed</a>");
            } else {
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
            String querySecond = "SELECT COUNT(*) FROM " + dbname;
            PreparedStatement countRows = con.prepareStatement(querySecond);
            ResultSet rowCount = countRows.executeQuery();
            ResultSetMetaData md = usuarios.getMetaData();
            int count = md.getColumnCount();
            PolicyFactory sanitizer = Sanitizers.FORMATTING.and(Sanitizers.BLOCKS);
            rowCount.next();
                if (request.getParameter("iamthemagicbutton") == null) {
               } else {
                    if (request.getParameter("iamthemagicbutton").equals("yesmakeit")) {
                    String comb = "UPDATE " + dbname + " SET ";
                    int columnCount = 1;
                    count = md.getColumnCount();
                    while (columnCount <= count-1) {
                            comb += md.getColumnName(columnCount) + " = ?, ";
                        columnCount++;
                    }
                    //columnCount++;
                    comb += md.getColumnName(columnCount) + " = ? ";
                    comb += "WHERE " + pk + " = ?";
                    columnCount = 1;
                    columnCount = 1;
                    PreparedStatement deletion = con.prepareStatement(comb);
                    while (columnCount <= count) {
                          if (request.getParameter(md.getColumnName(columnCount)).equals("")) {
                              deletion.setString(columnCount, null);
                          } else {
                              deletion.setString(columnCount, request.getParameter(md.getColumnName(columnCount)));
                          }
                          columnCount++;
                    }       
                    deletion.setString(columnCount, request.getParameter("row"));
                    deletion.execute();
                    out.println("<p>Your modification was succesful!</p>");
                    } 
                }
            %>
        <h1>Please, choose the row you want to modify.</h1>
        <form action="chooseDBModify.jsp" method="POST">
            <input type="number" name="row" min="1" max="<%= rowCount.getString(1) %>"></input><br><br>
              <input type="submit"></input>
        </form>
        <%
            out.println("<table>");
            out.print("<tr>");
            for (int i=1; i<=count; i++) {
            out.print("<th>");
            out.print(md.getColumnName(i));
            out.print("</th>");
            }
             out.println("</tr>");
             int counter = 1;
             while (users.next()) {
                 counter = 1;
                 out.println("<form action='chooseDBModify.jsp' method='POST'>");
                 out.println("<br>" + "<tr>"); 
                 while (counter <= count) {
                     String currentData = sanitizer.sanitize(users.getString(md.getColumnName(counter)));
                     out.println("<td>" + "<input type='" + "text" + "' value='"  + currentData + "' name='" + md.getColumnName(counter) + "'" + ">" + "</td>" );
                     counter++;
                 }
                 out.println("<input type='hidden' name='row' value='" + users.getString(pk) + "'>");
                 out.println("<input type='hidden' name='dbname' value='" + dbname + "'></input>");
                 out.println("<td><input type='submit' name='iamthemagicbutton' value='yesmakeit' onclick='setter(" + counter + ")'></td>");
                 out.println("</tr>");
                 out.println("</form>");
                 out.println("</table>");

             }
             con.close();
        }
        %>
    </body>
</html>
