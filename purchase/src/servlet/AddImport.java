package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.DBUtil;
import data.DataTool;

public class AddImport extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//设计页面的基本信息
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		DBUtil db = new DBUtil() ;
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>这是一个添加成员的处理页面</TITLE>");
		String orderID = request.getParameter("orderID") ;  //获取入库的订单ID
		String itemID = request.getParameter("itemID") ;  //获取物品的id
		String numberStr = request.getParameter("number") ;  //获取物品的数量
		int number = Integer.parseInt(numberStr) ;
		HttpSession session = request.getSession() ;
		
		String userID =(String) session.getAttribute("userID") ;  //获取用户的身份ID
		Date dnow = new Date(); 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String importTime = sdf.format(dnow);
		
		int count = 0;
		try {
			count = DataTool.getItemCount(itemID)+number;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String demandID = null;
		try {
			demandID = DataTool.getDemandIDByOrderID(orderID)  ;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String sql1="INSERT INTO import(OrderID,StockmanID,Importtime)"
				+ " VALUES('"+orderID+"','"+userID+"','"+importTime+"')";
		String sql2 = "UPDATE `item` SET `ItemsInventory` = "+count
				+ " WHERE `ItemID` = '"+itemID+"'" ;
		String sql3 = "UPDATE `order` SET `Statement` = '"+"采购完成"+"' "
				+ "WHERE `order`.`OrderID` = '"+orderID+"' " ;
		String sql4 = "UPDATE `demand` SET `Statement` = '"+"有货"+"' "
				+ "WHERE `demand`.`DemandID` = '"+demandID+"' " ;
		
		Connection conn = null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;
		PreparedStatement ps4 = null;
		try {
			conn = db.getConnection();
			conn.setAutoCommit(false);
			ps1 = conn.prepareStatement(sql1);
			ps2 = conn.prepareStatement(sql2);
			ps3 = conn.prepareStatement(sql3);
			ps4 = conn.prepareStatement(sql4);
			ps1.executeUpdate();
			ps2.executeUpdate();
			ps3.executeUpdate();
			ps4.executeUpdate();
			conn.commit();
			
			String u = request.getHeader("referer") ;
			String s = " <script type='text/javascript'>alert('插入成功');" ;
			s += "window.setTimeout(window.location='"+u+"',5000); </script></HEAD>" ;
			out.print(s+"</html>");
		} catch (SQLException sqle) {
			try {
				conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps1 != null) {
					ps1.close();
				}				
				if (ps2 != null) {
					ps2.close();
				}
				if (ps3 != null) {
					ps3.close();
				}
				if (ps4 != null) {
					ps4.close();
				}
			} catch (Exception e) {
				
			}
		}
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			
		}
		
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
