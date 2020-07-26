package dao;

import domain.User;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class UserDAO extends DAO<User> {
    public UserDAO(){
        super();
    }

   public User addUser(String username, String email, String password, Timestamp date){
        String  sql = "INSERT INTO `traveluser`(`username`, `email`,`pass`,`DateJoined`) VALUES (?,?,?,?)";
         update(sql,username,email,password,date);
         return get(username,password);

   }
   public User get(String username,String password){
        String  sql = "select uid id,username username,email email,pass password,DateJoined date from traveluser where username=? and pass=?";
        return getInstance(sql,username,password);
   }

}
