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

public class MessageDao {
	private rsFlush rf = new rsFlush();
    String sql="";

    private static MessageDao instance = new MessageDao();

    public static MessageDao getInstance() {
        return instance;
    }

    private Connection getConnection() throws Exception
    {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mysql");

        return ds.getConnection();
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
    
    public int getuser_id(String email) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = "";
        int user_id = 0;

        try {
            conn = getConnection();
            sql = "SELECT user_id FROM users WHERE email = ?";

            psmt =  conn.prepareStatement(sql);
            psmt.setString(1,email);
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
    
    public int getuser_idn(String nickname) throws Exception {
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
    
    
    public int receive_count(int receive_id) throws Exception{
    	Connection conn = null;
    	PreparedStatement psmt = null;
    	ResultSet rs = null;
    	String sql="";
    	int cnt =0;
    	try{
    		
    		conn = getConnection();
            sql = "SELECT COUNT(*) FROM message where receive_user = ?";

            psmt =   conn.prepareStatement(sql);
            psmt.setInt(1, receive_id);
            rs = psmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt(1);
			}else{
				cnt = 0;
			}
    	}catch(Exception e) {
			e.printStackTrace();
		}finally {
			rf.rsFlush(rs, psmt, conn);
		}
    	return cnt;
    	
    }
    
    public ArrayList<domain.Message> getMessage(int receive_user) throws Exception{
    	Connection con = getConnection();
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String email ="";
        ArrayList<domain.Message> alist = new ArrayList<domain.Message>();

        try {
            sql = "SELECT * from message where receive_user= ? order by m_id desc";
            psmt =  con.prepareStatement(sql);
            psmt.setInt(1,receive_user);
            rs = psmt.executeQuery();

            while(rs.next()) {
                domain.Message vo = new domain.Message();


                vo.setM_id(rs.getInt(1));
                vo.setTitle(rs.getString(2));
                vo.setContent(rs.getString(3));


                Date date = new Date();
                SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
                String year = (String)simpleDate.format(date);
                //String yea = rs.getString(4).substring(0,20);

                if(year.equals(rs.getString(4).substring(0, 10))){
                    vo.setSince(rs.getString(4).substring(10, 19));
                }else{
                    vo.setSince(rs.getString(4).substring(0, 10));
                }

                vo.setSend_user(rs.getInt(5));
                vo.setReceive_user(rs.getInt(6));
                vo.setIs_read(rs.getBoolean(7));
                alist.add(vo);

            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, con);
        }

        return alist;
    }
    public domain.Message getMessageList(int idx) throws Exception{
    	Connection con = getConnection();
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String email ="";
        domain.Message vo = new domain.Message();
        System.out.println("db : " + idx);
        try {
            sql = "SELECT * from message where m_id = ? order by m_id desc";
            psmt =  con.prepareStatement(sql);
            psmt.setInt(1, idx);
            rs = psmt.executeQuery();

            while(rs.next()) {
            	vo.setM_id(rs.getInt(1));
                vo.setTitle(rs.getString(2));
                vo.setContent(rs.getString(3));


                Date date = new Date();
                SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
                String year = (String)simpleDate.format(date);
                //String yea = rs.getString(4).substring(0,20);

                if(year.equals(rs.getString(4).substring(0, 10))){
                    vo.setSince(rs.getString(4).substring(10, 19));
                }else{
                    vo.setSince(rs.getString(4).substring(0, 10));
                }

                vo.setSend_user(rs.getInt(5));
                System.out.println(vo.getSend_user());
                vo.setReceive_user(rs.getInt(6));
                vo.setIs_read(rs.getBoolean(7));
           

            }

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(rs, psmt, con);
        }

        return vo;
    }
    
    public void readMessage(int m_id) throws Exception{
    	Connection con = getConnection();
        PreparedStatement pstmt = null;

        try {
            sql = "UPDATE message SET is_read=true where m_id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, m_id);
            pstmt.executeUpdate();

        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(pstmt, con);
        }
    }
    
    public void sendMessage(domain.Message vo)throws Exception{
    	Connection con = getConnection();
        PreparedStatement pstmt = null;


        try {
            sql = "insert into message(title,content,send_user,receive_user,since)values(?,?,?,?,now())";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getTitle());
            pstmt.setString(2, vo.getContent());
            pstmt.setInt(3, vo.getSend_user());
            pstmt.setInt(4, vo.getReceive_user());
            pstmt.execute();
        }catch(Exception e) {
            e.printStackTrace();
        }finally {
            rf.rsFlush(pstmt, con);
        }
    }
    
    public boolean hasUser(String nickname) throws Exception{
    	Connection con = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean hasUser = false;
        try {
            sql = "select count(*) from users where nickname=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, nickname);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	if(rs.getInt(1) == 0){
            		hasUser = false;
            	}else
            		hasUser =  true;
            	
            }
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
            rf.rsFlush(pstmt, con);
        }
    	return hasUser;
    }
    
}
