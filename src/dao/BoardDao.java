package dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.PreparedStatement;

import java.sql.Connection;
import java.util.Date;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 * Created by wontae on 2016. 9. 29..
 */
public class BoardDao {
    private rsFlush rf = new rsFlush();
    String sql="";

    private static BoardDao instance = new BoardDao();

    public static BoardDao getInstance() {
        return instance;
    }

    private Connection getConnection() throws Exception
    {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mysql");

        return ds.getConnection();
    }

    public int getMax() throws Exception {
        Connection con = getConnection();
        PreparedStatement psmt = null;
        ResultSet rs = null;
        int max = 0;

        try {
            sql = "SELECT MAX(user_id) FROM board";
            psmt = con.prepareStatement(sql);
            rs = psmt.executeQuery();

            if(rs.next()) {
                max=rs.getInt(1);
            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, con);
        }
        return max;
    }

    public void insertWrite(domain.Board vo, int user_id) throws Exception {
        Connection con = getConnection();
        PreparedStatement pstmt = null;


        try {
            sql = "INSERT INTO board(board_title,board_content,since,user_id) VALUES(?,?,NOW(),?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getBoard_title());
            pstmt.setString(2, vo.getBoard_content());
            pstmt.setInt(3, user_id);
            pstmt.execute();
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(pstmt, con);
        }
    }


    private String pasing(String board_title) {
        // TODO Auto-generated method stub
        return null;
    }

    public int count() throws Exception {
        Connection conn = null;
        java.sql.PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        int cnt = 0;

        try {
            conn = getConnection();
            sql = "SELECT COUNT(*) FROM board";

            psmt =   conn.prepareStatement(sql);

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

    public String getNickname(int user_id) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        String nickname ="";

        try {
            conn = getConnection();
            sql = "SELECT nickname FROM users WHERE user_id = ?";

            psmt =  conn.prepareStatement(sql);
            psmt.setInt(1,user_id);
            rs = psmt.executeQuery();

            if(rs.next()) {
                nickname=rs.getString("nickname");
            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return nickname;
    }

    public String getNickname(String email) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        String nickname ="";

        try {
            conn = getConnection();
            sql = "SELECT nickname FROM users WHERE email = ?";

            psmt =  conn.prepareStatement(sql);
            psmt.setString(1,email);
            rs = psmt.executeQuery();

            if(rs.next()) {
                nickname=rs.getString("nickname");
            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return nickname;
    }
    public int getUserid(String nickname) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        int user_id = 0;

        try {
            conn = getConnection();
            sql = "SELECT user_id FROM users WHERE nickname = ?";

            psmt =  conn.prepareStatement(sql);
            psmt.setString(1,nickname);
            rs = psmt.executeQuery();

            if(rs.next()) {
                user_id=rs.getInt("user_id");
            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return user_id;
    }

    public ArrayList<domain.Board> getMemberList() throws Exception {
        Connection con = getConnection();
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String email ="";
        ArrayList<domain.Board> alist = new ArrayList<domain.Board>();

        try {
            sql = "SELECT * from board order by board_id desc";
            psmt =  con.prepareStatement(sql);
            rs = psmt.executeQuery();

            while(rs.next()) {
                domain.Board vo = new domain.Board();


                vo.setBoard_id(rs.getInt(1));

                email = getNickname(rs.getInt("user_id"));
                vo.setEmail(email);
                vo.setBoard_title(rs.getString(2));


                Date date = new Date();
                SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
                String year = (String)simpleDate.format(date);
                //String yea = rs.getString(4).substring(0,20);

                if(year.equals(rs.getString(5).substring(0, 10))){
                    vo.setSince(rs.getString(5).substring(10, 19));
                }else{
                    vo.setSince(rs.getString(5).substring(0, 10));
                }

                vo.setHits(rs.getInt(4));
                alist.add(vo);

            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, con);
        }

        return alist;
    }

    public domain.Board getView(int idx) throws Exception {
        Connection con = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        domain.Board vo = null;

        try {
            sql = "SELECT board_title, board_content, hits, since, user_id FROM board WHERE board_id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, idx);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                vo = new domain.Board();
                vo.setBoard_title(rs.getString(1));
                vo.setBoard_content(rs.getString(2));
                vo.setHits(rs.getInt(3)+1);
                vo.setSince(rs.getString(4));
                vo.setUser_id(rs.getInt(5));
            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, pstmt, con);
        }
        return vo;
    }
    public void UpdateHit(int idx) throws Exception {
        Connection con = getConnection();
        PreparedStatement pstmt = null;

        try {
            sql = "UPDATE board SET hits=hits+1 where board_id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, idx);
            pstmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(pstmt, con);
        }
    }

    public void delete(int idx) throws Exception {
        Connection con = getConnection();
        PreparedStatement pstmt = null;

        try {
            sql = "DELETE FROM board WHERE board_id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, idx);
            pstmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(pstmt, con);
        }
    }


    public void modify(domain.Board vo, int idx) throws Exception {
        Connection con = getConnection();
        PreparedStatement pstmt = null;

        try {
            sql = "UPDATE board SET board_title=?, board_content=? where board_id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getBoard_title());
            pstmt.setString(2, vo.getBoard_content());
            pstmt.setInt(3, idx);
            pstmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(pstmt, con);
        }
    }

}
