package dao;

import domain.Song;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SongDao
{
    private rsFlush rf = new rsFlush();

    private static SongDao instance = new SongDao();

    public static SongDao getInstance() {
        return instance;
    }

    private Connection getConnection() throws Exception
    {
        Context initContext = new InitialContext();
        DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mysql");

        return ds.getConnection();
    }

    public int getSong_id(int ch_id) throws Exception
    {
        int song_id = -1;
        Connection conn = null;
        PreparedStatement psmt = null;

        ResultSet rs = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            String sql = "SELECT * FROM songs WHERE ch_id=?";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, ch_id);
            try{
                rs = psmt.executeQuery();
                conn.commit();
            }catch (SQLException sqle){
                conn.rollback();
            }


            if (rs.next()) {
                int cid = rs.getInt("ch_id");
                if (cid == ch_id)
                    song_id = rs.getInt("song_id");
            }

        }
        catch (Exception e) {
            e.printStackTrace();

        } finally {
            rf.rsFlush(rs, psmt, conn);
        }

        return song_id;
    }

    public void insertSong(String song_link, String song_name, String singer, int ch_id) throws Exception
    {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = null;


        try
        {
            sql = "INSERT INTO songs(song_link,song_name,singer,ch_id) VALUES (?,?,?,?)";
            conn = getConnection();
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, song_link);
            psmt.setString(2, song_name);
            psmt.setString(3, singer);
            psmt.setInt(4, ch_id);
            psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(psmt, conn);
        }
    }

    public ArrayList<Song> getSongList(int ch_id) throws Exception { ArrayList songlist = new ArrayList();
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        try
        {
            conn = getConnection();
            String sql = "SELECT song_id,song_link,song_name,singer FROM songs WHERE ch_id=?";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, ch_id);
            rs = psmt.executeQuery();

            while (rs.next()) {
                Song song = new Song();
                String YoutubeID = getYouTubeId(rs.getString("song_link"));
                song.setSong_link(YoutubeID);
                song.setSong_name(rs.getString("song_name"));
                song.setSong_id(rs.getInt("song_id"));
                song.setSinger(rs.getString("singer"));
                songlist.add(song);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(rs, psmt, conn);
        }
        return songlist;
    }

    public void deleteSong(int song_id) throws Exception {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = "";
        try {
            conn = getConnection();
            sql = "DELETE FROM songs WHERE song_id=?";
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, song_id);
            psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            rf.rsFlush(psmt, conn);
        }
    }


    private String getYouTubeId (String youTubeUrl) {
        String pattern = "(?<=youtu.be/|watch\\?v=|/videos/|embed\\/)[^#\\&\\?]*";
        Pattern compiledPattern = Pattern.compile(pattern);
        Matcher matcher;
        matcher = compiledPattern.matcher(youTubeUrl);
        if(matcher.find()){
            return matcher.group();
        } else {
            return "error";
        }
    }
    //

}