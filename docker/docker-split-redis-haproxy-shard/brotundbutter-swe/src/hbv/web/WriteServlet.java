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
      try {
	Database db = new Database();
        long insertId = db.doInsert("Moin");
	if (insertId > 0) {
		out.println("Success: " + insertId);
        	out.println("Hosted by: " + local);
	} else {
		out.println("Fail: " + insertId);
	}
      } catch (Exception e) {
      	out.println("Error: " + e.getMessage());
	e.printStackTrace(out);
      }
  }
}
