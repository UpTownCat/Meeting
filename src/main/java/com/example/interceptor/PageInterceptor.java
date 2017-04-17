package com.example.interceptor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Properties;

import org.apache.ibatis.binding.MapperMethod.ParamMap;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;

import com.example.bean.Page;
import com.example.util.CommonUtil;
@Intercepts({ @Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class }) })
public class PageInterceptor implements Interceptor {
	//在配置文件中获取
	private int pageSize;
	private final static long DAY = 1000 * 60 * 60 * 24;
	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		// TODO Auto-generated method stub
		boolean tag = invocation.getTarget() instanceof StatementHandler;
		if(tag) {
			StatementHandler statementHandler = (StatementHandler)invocation.getTarget();
			MetaObject metaObject = SystemMetaObject.forObject(statementHandler);
			MappedStatement mappedStatement = (MappedStatement)metaObject.getValue("delegate.mappedStatement");
			String id = mappedStatement.getId();
			boolean tag1 = "ByPage".equals(id.substring(id.length() - 6));
			if(tag1) {
				BoundSql boundSql = (BoundSql)metaObject.getValue("delegate.boundSql");
				String sql = boundSql.getSql();
				Page page = null;
				int condictionId = 0;
				Object object = boundSql.getParameterObject();
				if(object instanceof Page) {
					page = (Page) object;
				}else {
					ParamMap<Object> map = (ParamMap<Object>)object;
					page = (Page)map.get("0");
					condictionId = Integer.parseInt(map.get("userId").toString());
				}
				Connection conn = (Connection) invocation.getArgs()[0];
				String countSql = getCountSql(sql, page);
				//获取查询总页数的sql
				int count = getCount(conn, countSql, condictionId);
				page.setCount(count);
				int total = getTotalPage(page.getSize() == 0 ? pageSize : page.getSize(), count);
				page.setTotal(total);
				String pageSql = getPageSql(sql, page);
				metaObject.setValue("delegate.boundSql.sql", pageSql);
			}
		}
		return invocation.proceed();
	}

	@Override
	public Object plugin(Object arg0) {
		// TODO Auto-generated method stub
		if (arg0 instanceof StatementHandler) {
			return Plugin.wrap(arg0, this);
		} else {
			return arg0;
		}
	}

	@Override
	public void setProperties(Properties prop) {
		// TODO Auto-generated method stub
		String value = prop.getProperty("pageSize");
		pageSize = Integer.parseInt(value);
	}
	
	private String getPageSql(String sql, Page page) {
		StringBuffer str = new StringBuffer(sql);
		if(page.getSearchContent() != null && page.getSearchContent().length() != 0) {
			str.append(" and title like '%" + page.getSearchContent() + "%' ");
		}
		if(page.getName() != null && page.getName().length() != 0) {
			str.append(" and name like '%" + page.getName() + "%' ");
		}
		if(page.getNumber() != null && page.getNumber().length() != 0) {
			str.append(" and number like '%" + page.getNumber() + "%' ");
		}
		if(page.getAppointment() != 0) {
			if(page.getAppointment() == 1) {
				str.append(" and is_pass = " + page.getAppointment());
			}else {
				if(page.getAppointment() == 2){
					str.append(" and is_pass = " + 0);
				}else {
					str.append(" and is_pass = " + 2);
				}
			}
		}
		if(page.getState() != 0) {
			if(page.getState() == 1){
				str.append(" and end_time < '" + CommonUtil.dateToString2(new Date()) + "'");
			}
			else {
				if(page.getState() == 2) {
					str.append(" and start_time > '" + CommonUtil.dateToString2(new Date()) + "'");
				} else {
					str.append(" and start_time > '" + CommonUtil.dateToString2(new Date(System.currentTimeMillis() - DAY * 7)) + "' and end_time < '" + CommonUtil.dateToString2(new Date(System.currentTimeMillis() + (DAY * 7))) + "'");
				}
			}
		}
		if(page.getDepartmentId() != 0){
			str.append(" and department_id = " + page.getDepartmentId());
		}
		if(page.getTime() != 0) {
			if(page.getTime() == 1) {
				str.append(" order by start_time desc");
			}else {
				if(page.getTime() == 2){
					str.append(" order by start_time");
				}else {
					if(page.getTime() == 3) {
						str.append(" order by appointment_time desc");
					}else {
						str.append(" order by appointment_time");
					}
				}
				
			}
		}
		int capacity = page.getCapacity();
		if(capacity != 0) {
			if(capacity == 1){
				str.append(" order by capacity desc");
			}else {
				str.append(" order by capacity");
			}
		}
		int count = page.getCount2();
		if(count != 0) {
			if(count == 1){
				str.append(" order by count desc");
			}else {
				str.append(" order by count");
			}
		}
		str.append(" limit");
		int begin = (page.getIndex() - 1) * (page.getSize() == 0 ? pageSize : page.getSize());
		str.append(" " + begin);
		str.append(" ,");
		str.append(" " + (page.getSize() == 0 ? pageSize : page.getSize()));
		return str.toString();
	}
	
	/**
	 * 获得记录数量的sql
	 * @param sql
	 * @return
	 */
	private String getCountSql(String sql, Page page) {
		StringBuffer str = new StringBuffer("select count(*) from ");
		int index = sql.indexOf("from");
		str.append(sql.substring(index + 4));
		if(page.getSearchContent() != null && page.getSearchContent().length() != 0) {
			str.append(" and title like '%" + page.getSearchContent() + "%' ");
		}
		if(page.getName() != null && page.getName().length() != 0) {
			str.append(" and name like '%" + page.getName() + "%' ");
		}
		if(page.getNumber() != null && page.getNumber().length() != 0) {
			str.append(" and number like '%" + page.getNumber() + "%' ");
		}
		if(page.getAppointment() != 0) {
			if(page.getAppointment() == 1) {
				str.append(" and is_pass = " + page.getAppointment());
			}else {
				if(page.getAppointment() == 2){
					str.append(" and is_pass = " + 0);
				}else {
					str.append(" and is_pass = " + 2);
				}
			}
		}
		if(page.getState() != 0) {
			if(page.getState() == 1)
				str.append(" and end_time < '" + CommonUtil.dateToString2(new Date()) + "'");
			else
				str.append(" and start_time > '" + CommonUtil.dateToString2(new Date()) + "'");
		}
		if(page.getDepartmentId() != 0){
			str.append(" and department_id = " + page.getDepartmentId());
		}
		return str.toString();
	}
	
	/**
	 * 获得记录的总条数
	 * @param conn
	 * @param countSql
	 * @return
	 */
	private int getCount(Connection conn, String countSql, int condictionId) {
//		System.out.println("_________________" + countSql);
		PreparedStatement statement = null;
		try {
			 statement = conn.prepareStatement(countSql);
			 if(condictionId > 0) {
				 statement.setInt(1, condictionId);
			 }
			 ResultSet rs = statement.executeQuery();
			 rs.next();
			 return rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(statement != null) {
					statement.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return -1;	
	}
	
	/**
	 * 计算总共页数
	 * @param pageSize
	 * @param count
	 * @return
	 */
	private int getTotalPage(int pageSize, int count) {
		return count % pageSize == 0 ? count / pageSize : (count / pageSize) + 1;
	}

}
