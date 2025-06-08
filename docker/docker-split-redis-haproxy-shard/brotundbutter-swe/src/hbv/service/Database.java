package hbv.service;

import hbv.web.Product;
import java.io.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;


public class Database {
	static DataSource ds1;
	static DataSource ds2;
	static DataSource ds3;
	public static void init() {
		try{
			Context initCtx = new InitialContext();
			ds1 = (DataSource)initCtx.lookup("java:/comp/env/jdbc/mariadb1");
			ds2 = (DataSource)initCtx.lookup("java:/comp/env/jdbc/mariadb2");
			ds3 = (DataSource)initCtx.lookup("java:/comp/env/jdbc/mariadb3");
		}catch(NamingException ne){
			//TODO: dont write TODO in catch
		}
	}
	public Product doQuery(int id, int server){
		DataSource actual = (server == 1) ? ds1 : ds2;
		try (Connection connection = actual.getConnection(); 
		     PreparedStatement pss = connection.prepareStatement("select * from products where id = ?")) {
			
			pss.setInt(1,id);
			ResultSet rs = pss.executeQuery();

			if(rs.next()){
				return new Product(
					rs.getLong("id"),
					rs.getString("product_name"),
					rs.getString("product_origin"),
					rs.getFloat("price_per_kilo")
				);
			}
		} catch(Exception e){
			throw new RuntimeException(e);
		}
		return null;
	}
	public long doInsert(String name){
		long result=-1;
		try (Connection connection = ds3.getConnection();	
		     PreparedStatement ps = connection.prepareStatement(
			"insert into demo (name)  values(?)",Statement.RETURN_GENERATED_KEYS)) {

		  ps.setObject(1,name);
		  ps.executeUpdate();
		  try (ResultSet mrs=ps.getGeneratedKeys()) {
		    if(mrs.next()){
		      result=mrs.getLong(1);
		    }
		  }
		} catch(Exception e){
		  throw new RuntimeException("Error inserting data into database", e);
		}
		return result;
	}

}
