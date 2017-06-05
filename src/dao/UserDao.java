package dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao
{
    private rsFlush rf = new rsFlush();

    private static UserDao instance = new UserDao();

    public static UserDao getInstance() {
        return instance;
    }

    private Connection getConnection() throws Exception
    {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mysql");
        return ds.getConnection();
    }

    public int userCheck(String email, String password) throws Exception
    {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        String user_password = "";
        int check = -1;
        try
        {
            conn = getConnection();
            sql = "SELECT AES_DECRYPT(UNHEX(password), 'm532532') FROM users WHERE email = ?";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            rs = psmt.executeQuery();

            if (rs.next()) {
                user_password = rs.getString("AES_DECRYPT(UNHEX(password), 'm532532')");
                if (user_password.equals(password)) {
                    check = 1;
                }
                else
                    check = 0;
            }
            else {
                check = -1;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return check;
    }

    public void insertUser(String user_email, String user_nm, String user_password)
            throws Exception
    {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = "";
        try
        {
            conn = getConnection();
            //  INSERT INTO 테이블명 VALUES (HEX(AES_ENCRYPT('문자열', '암호화 키')));
            //sql = "insert into users(email,nickname,password,since)values (?,?,?,NOW())";

            sql = "INSERT INTO users(email,nickname,password,since)VALUES (?,?,HEX(AES_ENCRYPT(?, 'm532532')),NOW())";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, user_email);
            psmt.setString(2, user_nm);
            psmt.setString(3, user_password);
            psmt.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(psmt, conn);
        }
    }

    public int getUser_id(String email) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        int user_id = -1;
        try
        {
            conn = getConnection();
            String sql = "SELECT * FROM users WHERE email=?";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            rs = psmt.executeQuery();
            if (rs.next()) {
                String user_email = rs.getString("email");
                if (user_email.equals(email))
                    user_id = rs.getInt("user_id");
                else
                    user_id = 0;
            }
            else {
                user_id = -1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return user_id;
    }

    public String getNickname(String email) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String nickname = null;
        try
        {
            String sql = "SELECT * FROM users WHERE email=?";
            conn = getConnection();
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            rs = psmt.executeQuery();
            if (rs.next()) {
                String user_email = rs.getString("email");
                if (user_email.equals(email))
                    nickname = rs.getString("nickname");
                else
                    nickname = null;
            }
            else {
                nickname = "that user doesn't exist";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return nickname;
    }
    public void deleteUser(String email,String password) throws Exception {
        Connection conn=null;
        PreparedStatement psmt = null;
        String sql;
        try {
            sql="DELETE FROM users WHERE email=? AND AES_DECRYPT(UNHEX(password), 'm532532')=?";
            conn=getConnection();
            psmt=conn.prepareStatement(sql);
            psmt.setString(1,email);
            psmt.setString(2,password);
            psmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            rf.rsFlush(psmt,conn);
        }
    }
}