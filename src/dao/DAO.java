package dao;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAO<T> {
    private Class<T> clazz = null;
    private JdbcUtil jdbcUtils=new JdbcUtil();

    public DAO(){

        clazz = ReflectionUtil.getSuperClassGeneric(this.getClass());//this.getClass():CustomerDAO
    }


    public void m(){
        System.out.println(clazz);
    }

    //返回特殊的值的通用的方法
    public <E> E getValue(String sql, Object ...args){
        Connection conn=null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            //1.
            conn=jdbcUtils.getConnection();
            ps = conn.prepareStatement(sql);
            //2.
            for(int i = 0;i < args.length;i++){
                ps.setObject(i + 1, args[i]);
            }
            //3.
            rs = ps.executeQuery();
            if(rs.next()){
                return (E)rs.getObject(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            //4.
            jdbcUtils.close(rs, ps, conn);

        }

        return null;
    }

    //通用的查询，返回多条记录对应的一个集合
    public List<T> getForList(String sql, Object ... args){
        Connection conn=null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<T> list = new ArrayList<T>();
        try {
            //1.预编译sql语句，返回一个PreparedStatement的实例
            conn=jdbcUtils.getConnection();
            ps = conn.prepareStatement(sql);
            //2.填充占位符
            for(int i = 0;i < args.length;i++){
                ps.setObject(i + 1, args[i]);
            }

            //3.执行，返回一个结果集：ResultSet
            rs = ps.executeQuery();

            //4.处理结果集。(难点)
            //结果集的元数据：ResultSetMetaData
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();//获取了结果集的列数

            while(rs.next()){
                //创建一个Class对应的运行时类的对象
                T t = clazz.newInstance();// new Customer(); id=0,nume=null,...
                for(int i = 0;i < columnCount;i++){
                    Object columnVal = rs.getObject(i + 1);//获取的具体列的列值

                    String columnLabel = rsmd.getColumnLabel(i + 1);//获取列的别名

                    //通过反射装配属性值给t对象
                    Field field = clazz.getDeclaredField(columnLabel);
                    field.setAccessible(true);
                    field.set(t, columnVal);

                }
                list.add(t);
            }
            return list;


        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            //5.关闭资源
            jdbcUtils.close(rs, ps, conn);

        }
        return null;
    }

    //通用的查询，返回一条记录对应的一个对象
    public T getInstance(String sql,Object ... args){
        Connection conn=null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            //1.预编译sql语句，返回一个PreparedStatement的实例
            conn=jdbcUtils.getConnection();
            ps = conn.prepareStatement(sql);
            //2.填充占位符
            for(int i = 0;i < args.length;i++){
                ps.setObject(i + 1, args[i]);
            }

            //3.执行，返回一个结果集：ResultSet
            rs = ps.executeQuery();

            //4.处理结果集。(难点)
            //结果集的元数据：ResultSetMetaData
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();//获取了结果集的列数
            //创建一个Class对应的运行时类的对象
            T t = clazz.newInstance();// new Customer(); id=0,nume=null,...

            if(rs.next()){
                for(int i = 0;i < columnCount;i++){
                    Object columnVal = rs.getObject(i + 1);//获取的具体列的列值

                    String columnLabel = rsmd.getColumnLabel(i + 1);//获取列的别名

                    //通过反射装配属性值给t对象
                    Field field = clazz.getDeclaredField(columnLabel);
                    field.setAccessible(true);
                    field.set(t, columnVal);

                }
                return t;
            }


        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            //5.关闭资源
            jdbcUtils.close(rs, ps, conn);

        }
        return null;
    }

    //通用的增删改的方法
    public void update(String sql, Object... args) {
        Connection conn=null;
        PreparedStatement ps = null;
        try {
            // 1.预编译sql语句，返回一个PreparedStatement的实例
            conn=jdbcUtils.getConnection();
            ps = conn.prepareStatement(sql);
            // 2.填充占位符：？
            for (int i = 0; i < args.length; i++) {
                ps.setObject(i + 1, args[i]);
            }

            // 3.执行
            ps.executeUpdate();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            // 4.关闭资源
            jdbcUtils.close(null,ps,conn);

        }

    }
}