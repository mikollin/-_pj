package dao;


import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

public class ReflectionUtil{

    //获取形参所对应的运行时类的父类的泛型
    public static Class getSuperClassGeneric(Class clazz){//比如clazz为CustomerDAO


        Type superclass = clazz.getGenericSuperclass();//superclass : DAO<Customer>

       // ParameterizedType paramType = (ParameterizedType)superclass;
        Type[] types=null;
        if(superclass instanceof ParameterizedType){
                       // 强制转化“参数化类型”
                       ParameterizedType parameterizedType = (ParameterizedType) superclass;
                       // 参数化类型中可能有多个泛型参数
                       types = parameterizedType.getActualTypeArguments();
                       // 获取数据的第一个元素(User.class)
                       //clazz = (Class) types[0]; // com.oa.shore.entity.User.class
            //System.out.println("reflextion succeed");
            return (Class)types[0];
                   }
       // Type[] types = paramType.getActualTypeArguments();

        return null;//Customer.class
    }

}
