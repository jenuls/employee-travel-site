package connect;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;


public class connectDB
{
    
    public static Connection getMySqlConnect()
    {
        InitialContext ctx;
        Connection conn = null;
        try
        {
            ctx = new InitialContext();
            DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/travelDB");
            conn = ds.getConnection();
        } catch (NamingException e)
        {
            System.out.println("資料庫連線失敗....");
            e.printStackTrace();
        } catch (SQLException e)
        {
            // TODO Auto-generated catch block
            System.out.println("資料庫連線失敗....");
            e.printStackTrace();
        }
        conn = null;
        return conn;
        
        
    }
    
}
