package hbv.web;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import hbv.service.*;

public class WriteServlet extends HttpServlet {

  protected void doGet(HttpServletRequest  request,
      HttpServletResponse response)
      throws IOException, ServletException {

      response.setContentType("text/plain");
      PrintWriter out = response.getWriter();
      String local = request.getLocalName();
      Database db = new Database();
      db.doInsert("Moin");
      out.println("Hosted by: " + local);
  }
}
