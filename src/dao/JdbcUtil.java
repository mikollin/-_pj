package dao;

import java.sql.*;

/**
 * @Author duocai wu
 * @Date 2017/6/19
 * @Time 15:43
 */
public class JdbcUtil {
    private final static String URL = "jdbc:mysql://localhost:3306/Pj2"; //若没有改动，默认端口3306
    private final static String USER = "root"; // 安装mysql时的用户名
    private final static String PASSWORD = "root"; //安装mysql时的密码
    public JdbcUtil() {
        try {
// 反射
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    // 得到连接
    public Connection getConnection() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
    // 关闭结果集、语句和连接
    public void close(ResultSet rs, Statement st, Connection conn) {
        try {
            if (rs != null) { rs.close(); }
            if (st != null) { st.close(); }
            if (conn != null) { conn.close(); }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}