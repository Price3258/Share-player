package dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import dao.BoardDao;

/**
 * Created by wontae on 2016. 9. 29..
 */
public class ReplyDao {
    private rsFlush rf = new rsFlush();
    String sql="";



    private static ReplyDao instance = new ReplyDao();

    public static ReplyDao getInstance() {
        return instance;
    }

    private Connection getConnection() throws Exception
    {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mysql");

        return ds.getConnection();
    }


    public void insertReply(domain.Reply vo) throws Exception {		//댓글 입력
        Connection con = getConnection();
        PreparedStatement pstmt = null;


        try {
            sql = "INSERT INTO reply(reply_content,user_id,board_id,since) VALUES(?,?,?,NOW())";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getReply_content());
            pstmt.setInt(2, vo.getUser_id());
            pstmt.setInt(3, vo.getBoard_id());
            System.out.println("db : " + vo.getReply_content());
            System.out.println("db : " + vo.getUser_id());
            System.out.println("db : " + vo.getBoard_id());

            pstmt.execute();
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(pstmt, con);
        }
    }

    public ArrayList<domain.Reply> getThisReply(int idx) throws Exception {
        Connection con = getConnection();
        PreparedStatement psmt = null;
        ResultSet rs = null;

        ArrayList<domain.Reply> alist = new ArrayList<domain.Reply>();

        try {
            sql = "SELECT * from reply where board_id=?";
            psmt =  con.prepareStatement(sql);
            psmt.setInt(1, idx);
            rs = psmt.executeQuery();
            BoardDao bd = BoardDao.getInstance();


            while(rs.next()) {
                domain.Reply vo = new domain.Reply();

                vo.setReply_id(rs.getInt(1));
                vo.setReply_content(rs.getString(2));
                vo.setSince(rs.getString(3).substring(0, 9));
                vo.setUser_id(rs.getInt(4));
                vo.setBoard_id(rs.getInt(5));

                alist.add(vo);

            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, con);
        }

        return alist;
    }


    public int count(int idx) throws Exception {
        Connection conn = null;
        java.sql.PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        int cnt = 0;

        try {
            conn = getConnection();
            sql = "SELECT COUNT(*) FROM reply WHERE board_id = ?";

            psmt =   conn.prepareStatement(sql);
            psmt.setInt(1, idx);
            rs = psmt.executeQuery();

            if(rs.next()) {
                cnt=rs.getInt(1);
            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return cnt;
    }

    public void deleteReply(int idx) throws Exception{
        Connection conn = null;
        PreparedStatement psmt = null;

        try {
            conn = getConnection();
            sql = "delete from reply where reply_id = ?";

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, idx);
            psmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush( psmt, conn);
        }

    }

}
