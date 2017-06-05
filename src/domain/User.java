package domain;

public class User
{
    private int user_id;
    private String user_email;
    private String user_pw;
    private String user_nm;

    public String getUser_nm()
    {
        return this.user_nm;
    }

    public void setUser_nm(String user_nm) {
        this.user_nm = user_nm;
    }

    public User(String user_email, String user_nm, String user_pw) {
        this.user_email = user_email;
        this.user_nm = user_nm;
        this.user_pw = user_pw;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
    public int getUser_id() {
        return this.user_id;
    }

    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }
    public String getUser_email() {
        return this.user_email;
    }
    public void setUser_pw(String user_pw) {
        this.user_pw = user_pw;
    }
    public String getUser_pw() {
        return this.user_pw;
    }
}