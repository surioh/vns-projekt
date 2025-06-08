package hbv.web;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import hbv.service.*;

public class ReadServlet extends HttpServlet {

  protected void doGet(HttpServletRequest  request,
      HttpServletResponse response)
      throws IOException, ServletException {

      String idStr = request.getParameter("id");

      response.setContentType("text/plain");
      PrintWriter out = response.getWriter();
      //out.println("Received Parameter: "+idStr);
      try {
        int id = Integer.parseInt(idStr);
	//out.println("Integer convert: "+id);
      	Database db = new Database();
	Product product = db.doQuery(id);

	if (product != null) {
		out.println(product.output());
	} else {
		out.println("Product not found");
	} 
      } catch (Exception e) {
	throw new RuntimeException();
      }
  }
}
