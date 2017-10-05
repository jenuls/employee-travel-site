package connect;

import java.sql.*;
import java.util.*;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import myutil.DateUtil;
import myutil.strUtil;

import com.mysql.jdbc.Util;

import jdbc.CommonJavaBean;

import jdbc.*;

public class TravelAction
{
    private CommonJavaBean commonJB;

    private boolean DEBUG = true;

    InitialContext context = null;

    

    public Connection getConnection(String dataSource) throws NamingException, SQLException
    {
        DataSource ds = (DataSource) context.lookup(dataSource);
        Connection conn = ds.getConnection();
        //conn.setAutoCommit(false);
        return conn;
    }

}
