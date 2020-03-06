package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import org.owasp.html.HtmlPolicyBuilder;
import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;

public final class AddDataDB_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("     <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\" integrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\" crossorigin=\"anonymous\">\n");
      out.write("     <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css\">     <!-- Tres enlaces con librerias de JS de Bootstrap -->\n");
      out.write("   <script src=\"https://code.jquery.com/jquery-3.3.1.slim.min.js\" integrity=\"sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo\" crossorigin=\"anonymous\"></script>\n");
      out.write("     <script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js\" integrity=\"sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1\" crossorigin=\"anonymous\"></script>\n");
      out.write("     <script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\" integrity=\"sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM\" crossorigin=\"anonymous\"></script>\n");
      out.write("     <link rel=\"stylesheet\" href=\"login.css\">\n");
      out.write("     <link rel=\"stylesheet\" href=\"dentistCRUD.css\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Add</title>\n");
      out.write("        \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <h1>Add the new row.</h1>\n");
      out.write("        ");

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
                out.println("<p>Only the admininstrators of the server can add data to the table usuarios, you have to login as the admininstrator before making adding users or querying this database, if you need it, refer to your admininstrator.</p>");
                out.println("<p>Warning, to all possible intruders, all database modifications in Users are throughfully recorded in the server, <strong>do not proceed if you are not an authorized user</strong>. Prosecution and legal claims may proceed.</p>");
                out.println("<a href='/CRUDPabloMolinaBlanes12/chooseDBAddUsuarioMain.jsp'>Proceed</a>");
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
            ResultSetMetaData md = usuarios.getMetaData();
                if (request.getParameter("iamthemagicbutton") == null) {
               } else {
                   if (request.getParameter("iamthemagicbutton").equals("yesmakeit")) {
                    String comb = "INSERT INTO " + dbname + " (";
                    int columnCount = 1;
                    int count = md.getColumnCount();
                    while (columnCount <= count-1) {
                        if (!md.getColumnName(columnCount).equals(pk)) {
                            comb += md.getColumnName(columnCount) + ", ";
                        }
                        columnCount++;
                    }
                    //columnCount++;
                    comb += md.getColumnName(columnCount);
                    comb += ") VALUES (";
                    columnCount = 1;
                    while (columnCount <= count-1) {
                        if (!md.getColumnName(columnCount).equals(pk)) {
                            comb += "?, ";
                        }
                        columnCount++;
                    }
                    //columnCount++;
                    comb += "?)";
                    PreparedStatement deletion = con.prepareStatement(comb);
                    columnCount = 1;
                    while (columnCount <= count) {
                        if (!md.getColumnName(columnCount).equals(pk)) {
                          deletion.setString(columnCount, request.getParameter(md.getColumnName(columnCount)));
                        }
                        columnCount++;
                    }
                    deletion.execute();
                    out.println("<p>Your addition was succesful!</p>");
                   }
                }
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
        
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
