<%@page import="divMangere.RequestNotice"%>
<%@page import="divMangere.ReceExamine"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	//未登录跳转
	Object obj = session.getAttribute("userID");
	String zhi_wei = (String)session.getAttribute("zhiwei");
	if(obj == null||!("市场部门经理".equals(zhi_wei)||"财务部门经理".equals(zhi_wei)||"生产部门经理".equals(zhi_wei)||"研发部门经理".equals(zhi_wei)||"销售部门经理".equals(zhi_wei))){
	response.sendRedirect("login.jsp");
	}
	String userName = (String)session.getAttribute("userName") ;
%>

<jsp:useBean id="divMangere" class="divMangere.DivMangere" scope="page"></jsp:useBean>
<%
	String userID = (String)session.getAttribute("userID") ;
	divMangere.setUserID(userID) ;
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>DivMangere||Notice</title>

	<link rel="stylesheet" type="text/css" href="css/divMangere.css">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	 <script type="text/javascript">
 	function handle(val){
		window.location.href = "divMangere-handle.jsp?requestID="+val ;
 	}
 	
	</script>
	<script type="text/javascript" src="js/CookieUtil.js"></script>
	<script type="text/javascript">
		var quit = function(){
			CookieUtil.unset("userID") ;
			CookieUtil.unset("password") ;
		}
	</script>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<script src="js/jquery-1.3.min.js" type="text/javascript"></script>
	<script src="js/script.js" type="text/javascript"></script>
  </head>
  
  <body>
    <header id="header">
		<hgroup>
			<h1 class="site_title">Function</h1>
			<h2 class="section_title">Dashboard</h2>
			<div class="btn_help">
				<a href="">Help</a>
			</div>
		</hgroup>
	</header>
	<!--end of first header-->
	<section id="second_bar">
		<div class="user">
		 		<%
		 			int count = 0 ;
		 			String[] s = new String[100] ;
 					divMangere.setRequestNotices() ;
 					ArrayList<RequestNotice> requestNotices = divMangere.getRequestNotices() ;
 					Iterator<RequestNotice> divrequ = requestNotices.iterator() ;
 					while(divrequ.hasNext()){
 						RequestNotice r = divrequ.next() ;
 						s[count] = "<p class='bg-info noticeCon' >" ;
 						s[count] += "你有订单号为<a onclick='handle(this.innerHTML)'>"+r.getRequestID()+"</a>的申请单需要审核" ;
 						s[count] += "</p>" ;
 						count++ ;
 					}
 					session.setAttribute("count", count) ;
				 %> 
			<p><%=userName  %>（
				<a href=""><%=count %>个未处理</a>
				）
			</p>
		</div>
		<div class="web_palce">
			<article class="place">
				<a   class="user_status" href="divMangere-notice.jsp">部门经理</a>
				<div class="place_driver"></div>
				<a  class="current" href="#">待办事项</a>	
			</article>
		</div>
	</section>
	<!-- end second bar -->
	<aside id="side_bar">
		<div>
			<p id="alt">请选择</p>
			<hr>
		</div>
		<div class="function">
			<div id="notify"><a href="divMangere-notice.jsp">待办事项</a></div>
			<div id="query"><a href="divMangere-query.jsp">订单查看</a></div>
			<div id="work"><a href="divMangere-work.jsp">业务查看</a></div>
			<div id="exit"><a href="doQuit.jsp" onclick="quit()">退出登录</a></div>
		</div>
		<footer>
			<hr />
			<p>Copyright &copy; 2015 Silence</p>
			<p>Design by <a href="">Silence</a></p>
		</footer>
	</aside>
	<!-- end sidebar -->
	<section id="main">
		<div id = "main_div">
			<header class="notice">
				<h3>通知</h3>
			</header>
			<div class="noticeContext">
 				<%
 					for(int i = 0 ;i<count;i++){
 						out.print(s[i]) ;
 					}
				 %> 
			</div>
		</div>
		<div id="side_div1">
			<header id="time">
				<h3>时间</h3>
			</header>
			<table cellspacing="0">
			  <thead>
			    <tr>
			      <th>Mon</th>
			      <th>Tue</th>
			      <th>Wed</th>
			      <th>Thu</th>
			      <th>Fri</th>
			      <th>Sat</th>
			      <th>Sun</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td class="padding" colspan="3"></td>
			      <td> 1</td>
			      <td> 2</td>
			      <td> 3</td>
			      <td> 4</td>
			    </tr>
			    <tr>
			      <td> 5</td>
			      <td> 6</td>
			      <td> 7</td>
			      <td> 8</td>
			      <td class="today"> 9</td>
			      <td>10</td>
			      <td>11</td>
			    </tr>
			    <tr>
			      <td>12</td>
			      <td class="date_has_event"> 13
			        <div class="events">
			          <ul>
			            <li> <span class="title">Event 1</span> <span class="desc">Lorem ipsum dolor sit amet, consectetu adipisicing elit.</span> </li>
			            <li> <span class="title">Event 2</span> <span class="desc">Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</span> </li>
			          </ul>
			        </div></td>
			      <td>14</td>
			      <td>15</td>
			      <td>16</td>
			      <td>17</td>
			      <td>18</td>
			    </tr>
			    <tr>
			      <td>19</td>
			      <td>20</td>
			      <td>21</td>
			      <td class="date_has_event"> 22
			        <div class="events">
			          <ul>
			            <li> <span class="title">Event 1</span> <span class="desc">Lorem ipsum dolor sit amet, consectetu adipisicing elit.</span> </li>
			            <li> <span class="title">Event 2</span> <span class="desc">Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</span> </li>
			          </ul>
			        </div></td>
			      <td>23</td>
			      <td>24</td>
			      <td>25</td>
			    </tr>
			    <tr>
			      <td>26</td>
			      <td>27</td>
			      <td>28</td>
			      <td>29</td>
			      <td>30</td>
			      <td>31</td>
			      <td class="padding"></td>
			    </tr>
			  </tbody>
			</table>
		</div>

		<div id="side_div2">
			 <header id="curRecord">
			 	<h3>最近审核记录</h3>
			 </header>
			 <table class="table table-striped table-hover table-bordered" style="font-size: 0.9em">
			 		<thead>
			 			<tr>
			 				<td>申请单ID</td>
			 				<td>物品名称</td>
			 				<td>数量</td>
			 				<td>总金额</td>
			 				<td>申请人</td>
			 				<td>审核时间</td>
			 			</tr>
			 		</thead>
			 		
			 		<tbody>
			 				<%
			 					
			 					divMangere.setReceExamines() ;
			 					ArrayList<ReceExamine> receExamines = divMangere.getReceExamines() ;
			 					
			 					Iterator<ReceExamine> receExamineIterator = receExamines.iterator() ;
			 					
			 					while(receExamineIterator.hasNext()){
			 						ReceExamine rece = receExamineIterator.next() ;
			 						out.print("<tr>") ;
			 						out.print("<td>"+rece.getRequestID()+"</td>") ;
			 						out.print("<td>"+rece.getItemName()+"</td>") ;
			 						out.print("<td>"+rece.getNumber()+"</td>") ;
			 						out.print("<td>"+rece.getAccount()+"</td>") ;
			 						out.print("<td>"+rece.getRequestName()+"</td>") ;
			 						out.print("<td>"+rece.getRequestTime()+"</td>")  ;
			 						out.print("</td>") ;
			 					}
			 				 %>
			 		</tbody>
			 	</table>
		</div>
	</section>
  </body>
</html>
