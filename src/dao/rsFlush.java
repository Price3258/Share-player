package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class rsFlush
{
    private static rsFlush instance = new rsFlush();

    public static rsFlush getInstance() {
        return instance;
    }

    public void rsFlush(ResultSet rs, PreparedStatement psmt, Connection conn)
            throws Exception
    {
        if (rs != null)
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        if (psmt != null)
            try {
                psmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        if (conn != null)
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
    }

    public void rsFlush(PreparedStatement psmt, Connection conn)
            throws Exception
    {
        if (psmt != null)
            try {
                psmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        if (conn != null)
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
    }
}