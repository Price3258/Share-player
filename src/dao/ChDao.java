package dao;

import domain.Channel;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ChDao
{
    private rsFlush rf = new rsFlush();

    private static ChDao instance = new ChDao();

    public static ChDao getInstance() {
        return instance;
    }

    private Connection getConnection() throws Exception
    {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mysql");

        return ds.getConnection();
    }

    public int chCheck(int user_id) throws Exception
    {
        int check = -1;

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        int usr_id = 0;
        try
        {
            conn = getConnection();
            sql = "SELECT * FROM channels WHERE user_id=?";

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, user_id);
            rs = psmt.executeQuery();

            if (rs.next()) {
                usr_id = rs.getInt("user_id");
                if (usr_id == user_id) {
                    check = 1;
                }
                else
                    check = 0;
            }
            else
            {
                check = -1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }

        return check;
    }

    public void insertCh(String ch_name, int user_id) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = "";
        try
        {
            conn = getConnection();
            sql = "INSERT INTO channels(ch_name,user_id)VALUES (?,?)";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, ch_name);
            psmt.setInt(2, user_id);
            psmt.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(psmt, conn);
        }
    }

    public int getChid(int user_id) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        int ch_id = 0;
        try
        {
            conn = getConnection();
            sql = "SELECT * FROM channels WHERE user_id=?";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, user_id);
            rs = psmt.executeQuery();
            if (rs.next()) {
                int uid = rs.getInt("user_id");
                if (uid == user_id)
                    ch_id = rs.getInt("ch_id");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }

        return ch_id;
    }
    public int getUser_id(int ch_id) throws Exception {
        Connection conn=null;
        PreparedStatement psmt=null;
        ResultSet rs= null;
        int user_id=0;
        try{
            conn=getConnection();
            String sql="SELECT * FROM channels WHERE ch_id=?";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1,ch_id);
            rs=psmt.executeQuery();
            if (rs.next()){
                int chid=rs.getInt("ch_id");
                if(chid==ch_id)
                    user_id =rs.getInt("user_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return user_id;
    }

    public String getChName(int ch_id) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        String ch_nm = "";
        try
        {
            conn = getConnection();
            sql = "SELECT * FROM channels WHERE ch_id=?";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, ch_id);
            rs = psmt.executeQuery();

            if (rs.next()) {
                int chid = rs.getInt("ch_id");
                if (chid == ch_id)
                    ch_nm = rs.getString("ch_name");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }

        return ch_nm;
    }


    // get All Channel
    public ArrayList<Channel> getChannelList() throws Exception {
        ArrayList chList = new ArrayList();
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        try
        {
            conn = getConnection();

            sql = "SELECT users.user_id,users.email,users.nickname,channels.ch_id, channels.ch_name FROM users RIGHT JOIN channels ON users.user_id=channels.user_id";
            psmt = conn.prepareStatement(sql);
            rs = psmt.executeQuery();
            while (rs.next()) {
                Channel ch = new Channel();
                ch.setCh_id(rs.getInt("ch_id"));
                ch.setUser_id(rs.getInt("user_id"));
                ch.setEmail(rs.getString("email"));
                ch.setNickname(rs.getString("nickname"));
                ch.setCh_name(rs.getString("ch_name"));
                chList.add(ch);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return chList;
    }
    public void UpdateChName(String ch_name, int ch_id) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        try
        {
            conn = getConnection();
            String sql = "UPDATE channels SET ch_name=? WHERE ch_id=?";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, ch_name);
            psmt.setInt(2, ch_id);
            psmt.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(psmt, conn);
        }
    }

    public ArrayList<Channel> getOwnChannelList(int user_id) throws Exception {
        ArrayList chList = new ArrayList();
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        try
        {
            conn = getConnection();

            sql = "SELECT users.user_id,users.email,users.nickname,channels.ch_id, channels.ch_name FROM users RIGHT JOIN channels ON users.user_id=channels.user_id WHERE users.user_id=?";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1,user_id);
            rs = psmt.executeQuery();
            while (rs.next()) {
                Channel ch = new Channel();
                ch.setCh_id(rs.getInt("ch_id"));
                ch.setUser_id(rs.getInt("user_id"));
                ch.setEmail(rs.getString("email"));
                ch.setNickname(rs.getString("nickname"));
                ch.setCh_name(rs.getString("ch_name"));
                chList.add(ch);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return chList;
    }
    public void deleteChannel(int ch_id) throws Exception {
        Connection conn=null;
        PreparedStatement psmt = null;
        String sql;
        try {
            sql="DELETE FROM channels WHERE ch_id=?";
            conn=getConnection();
            psmt=conn.prepareStatement(sql);
            psmt.setInt(1,ch_id);
            psmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            rf.rsFlush(psmt,conn);
        }
    }

    public ArrayList<Channel> getSearchChannelList(String name) throws Exception {
        ArrayList chList = new ArrayList();
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        try
        {
            conn = getConnection();

            sql = "SELECT users.user_id,users.email,users.nickname,channels.ch_id, channels.ch_name FROM users RIGHT JOIN channels ON users.user_id=channels.user_id WHERE ch_name LIKE ?";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1,"%"+name+"%");
            rs = psmt.executeQuery();

            while (rs.next()) {
                Channel ch = new Channel();
                ch.setCh_id(rs.getInt("ch_id"));
                ch.setUser_id(rs.getInt("user_id"));
                ch.setEmail(rs.getString("email"));
                ch.setNickname(rs.getString("nickname"));
                ch.setCh_name(rs.getString("ch_name"));
                chList.add(ch);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return chList;
    }


}