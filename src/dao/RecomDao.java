package dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by wontae on 2016. 10. 11..
 */
public class RecomDao {
    private rsFlush rf = new rsFlush();

    private static RecomDao instance = new RecomDao();

    public static RecomDao getInstance() {
        return instance;
    }

    private Connection getConnection() throws Exception
    {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mysql");

        return ds.getConnection();
    }

    public int recomCheck(int ch_id,int user_id) throws Exception {
        Connection conn=null;
        PreparedStatement psmt = null;
        ResultSet rs= null;
        int check=-1;

        int uid=0; //user_ID for equals

        try{
            conn=getConnection();
            String sql="SELECT user_id FROM recommend WHERE ch_id=?";

            psmt=conn.prepareStatement(sql);
            psmt.setInt(1,ch_id);
            rs=psmt.executeQuery();

            if(rs.next()){
                uid=rs.getInt("user_id");
                System.out.println("uid"+uid);
                if(uid==user_id){
                    check=1;// whether user recommend
                    System.out.println("check's value is"+check);
                }
                else
                    check=0; // or not
                System.out.println("check's value is"+check);
            }
            else{
                System.out.println("check's value is"+check);
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            rf.rsFlush(psmt,conn);
        }
        return check;
    }

    public void insertReco(int ch_id,int user_id) throws Exception {
        Connection conn= null;
        PreparedStatement psmt = null;
        String sql=null;
        int add=1;
        try {
            conn=getConnection();
            sql = "INSERT INTO recommend(recom,ch_id,user_id) VALUES (?,?,?)";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, add);
            psmt.setInt(2,ch_id);
            psmt.setInt(3,user_id);
            psmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(psmt, conn);
        }
    }
    public void insertNonReco(int ch_id,int user_id) throws Exception {
        Connection conn= null;
        PreparedStatement psmt = null;
        String sql=null;
        try {
            conn=getConnection();
            sql = "INSERT INTO recommend(nonrecom,ch_id,user_id) VALUES (?,?,?)";
           // sql = "INSERT INTO recommend(nonrecom,ch_id,user_id) VALUES (?,?,?)";

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1,1);
            psmt.setInt(2,ch_id);
            psmt.setInt(3,user_id);
            psmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(psmt, conn);
        }
    }

    public int getRecom(int ch_id) throws Exception {
        Connection conn=null;
        PreparedStatement psmt=null;
        ResultSet rs = null;
        int recommend=-1;

        try{
            conn=getConnection();
            String sql="SELECT SUM(recom) FROM recommend WHERE ch_id=?";
            psmt=conn.prepareStatement(sql);
            psmt.setInt(1,ch_id);
            rs=psmt.executeQuery();

            if(rs.next()){
                recommend=rs.getInt("SUM(recom)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs,psmt,conn);
        }
        return recommend;
    }
    public int getNonRecom(int ch_id) throws Exception {
        Connection conn=null;
        PreparedStatement psmt=null;
        ResultSet rs = null;
        int nonrecommend=-1;

        try{
            conn=getConnection();
            String sql="SELECT SUM(nonrecom) FROM recommend WHERE ch_id=?";
            psmt=conn.prepareStatement(sql);
            psmt.setInt(1,ch_id);
            rs=psmt.executeQuery();

            if(rs.next()){
                nonrecommend=rs.getInt("SUM(nonrecom)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs,psmt,conn);
        }
        return nonrecommend;
    }
}
