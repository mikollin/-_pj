package domain;

import java.sql.Timestamp;
public class User {
    private String username;
    private String email;
    private String password;
    private Timestamp date;
    private Integer id;

    public User(){

    }
    public User(String username, String email, String password, Timestamp date){
        this.username=username;
        this.email=email;
        this.password=password;
        this.date=date;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
