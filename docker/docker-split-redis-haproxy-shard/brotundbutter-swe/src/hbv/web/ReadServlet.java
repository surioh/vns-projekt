package hbv.web;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import redis.clients.jedis.*;
import hbv.service.*;

public class ReadServlet extends HttpServlet {

  protected void doGet(HttpServletRequest  request,
      HttpServletResponse response)
      throws IOException, ServletException {

      String idStr = request.getParameter("id");

      response.setContentType("text/plain");
      PrintWriter out = response.getWriter();
      String local = request.getLocalName();
      try (Jedis jedis = new Jedis("redis", 6379)) {
	jedis.auth(Config.getProperty("service_password"));
	
	
        int id = Integer.parseInt(idStr);
	String redisKey = "product:" + id;
	String cachedData = jedis.get(redisKey);
	if (cachedData != null) {
		out.println("Redis: " + cachedData);
		out.println("Hosted by: " + local);
		return;
	} 
      	Database db = new Database();
	int server = (id <= 50) ? 1 : 2;
	out.println("server: " + server);
	Product product = db.doQuery(id, server);

	if (product != null) {
		out.println("Mariadb: " + product.output());
		out.println("Hosted by: " + local);
		jedis.setex(redisKey, 300, product.output());
	} else {
		out.println("Product not found");
	} 
      } catch (Exception e) {
	throw new RuntimeException();
      }
  }
}
