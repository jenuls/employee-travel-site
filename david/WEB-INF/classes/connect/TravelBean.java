package connect;

import java.sql.*;
import java.util.*;

import myutil.DateUtil;
import myutil.strUtil;

import com.mysql.jdbc.Util;

import jdbc.CommonJavaBean;

import jdbc.*;

public class TravelBean
{
    private CommonJavaBean commonJB;

    private boolean DEBUG = true;

    public TravelBean()
    {
        commonJB = new CommonJavaBean();
    }

    /**
     * 取得員工報名資料
     * 
     * @return
     */
    public Collection getJoinDetail(String employeeNo)
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT re.travelNo,                                      ");
        sql.append("        tr.travelName,                                    ");
        sql.append("        re.employeeNo,                                    ");
        sql.append("        re.name,                                          ");
        sql.append("        re.money,                                         ");
        sql.append("        ro.roomNo,                                        ");
        sql.append("        ro.roomDetailNo,                                  ");
        sql.append("        de.deskNo,                                        ");
        sql.append("        de.deskDetailNo,                                  ");
        sql.append("        ve.vehicleNo,                                     ");
        sql.append("        ve.vehicleDetailNo                                ");
        sql.append("   FROM    (   (   (   registration re                    ");
        sql.append("                    INNER JOIN                            ");
        sql.append("                       travel tr                          ");
        sql.append("                    ON (re.travelNo = tr.travelNo))       ");
        sql.append("                LEFT OUTER JOIN                           ");
        sql.append("                   roommember ro                          ");
        sql.append("                ON     (re.travelNo = ro.travelNo)        ");
        sql.append("                   AND (re.employeeNo = ro.employeeNumber)");
        sql.append("                   AND (re.name = ro.MemberName))         ");
        sql.append("            LEFT OUTER JOIN                               ");
        sql.append("               deskmember de                              ");
        sql.append("            ON     (re.travelNo = de.travelNo)            ");
        sql.append("               AND (re.employeeNo = de.employeeNumber)    ");
        sql.append("               AND (re.name = de.memberName))             ");
        sql.append("        LEFT OUTER JOIN                                   ");
        sql.append("           vehiclemember ve                               ");
        sql.append("        ON     (re.travelNo = ve.travelNo)                ");
        sql.append("           AND (re.employeeNo = ve.employeeNumber)        ");
        sql.append("           AND (re.name = ve.memberName)                  ");
        sql.append("  WHERE (re.employeeNo = ?)                               ");
        ArrayList valueList = new ArrayList();
        valueList.add(employeeNo);
        return commonJB.query(sql.toString(), valueList);

    }
    
    
    /**
     * 取得所有員工報名資料
     * 
     * @return
     */
    public Collection getJoinDetail()
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT re.travelNo,                                      ");
        sql.append("        tr.travelName,                                    ");
        sql.append("        re.employeeNo,                                    ");
        sql.append("        re.name,                                          ");
        sql.append("        re.money,                                         ");
        sql.append("        ro.roomNo,                                        ");
        sql.append("        ro.roomDetailNo,                                  ");
        sql.append("        de.deskNo,                                        ");
        sql.append("        de.deskDetailNo,                                  ");
        sql.append("        ve.vehicleNo,                                     ");
        sql.append("        ve.vehicleDetailNo                                ");
        sql.append("   FROM    (   (   (   registration re                    ");
        sql.append("                    INNER JOIN                            ");
        sql.append("                       travel tr                          ");
        sql.append("                    ON (re.travelNo = tr.travelNo))       ");
        sql.append("                LEFT OUTER JOIN                           ");
        sql.append("                   roommember ro                          ");
        sql.append("                ON     (re.travelNo = ro.travelNo)        ");
        sql.append("                   AND (re.employeeNo = ro.employeeNumber)");
        sql.append("                   AND (re.name = ro.MemberName))         ");
        sql.append("            LEFT OUTER JOIN                               ");
        sql.append("               deskmember de                              ");
        sql.append("            ON     (re.travelNo = de.travelNo)            ");
        sql.append("               AND (re.employeeNo = de.employeeNumber)    ");
        sql.append("               AND (re.name = de.memberName))             ");
        sql.append("        LEFT OUTER JOIN                                   ");
        sql.append("           vehiclemember ve                               ");
        sql.append("        ON     (re.travelNo = ve.travelNo)                ");
        sql.append("           AND (re.employeeNo = ve.employeeNumber)        ");
        sql.append("           AND (re.name = ve.memberName)                  ");
       
        ArrayList valueList = new ArrayList();
       
        return commonJB.query(sql.toString(), valueList);

    }
    
    
    /**
     * 取得所有員工報名資料，依旅遊行程及員工編號排序
     * 
     * @return
     */
    public Collection getJoinDetail2()
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT re.travelNo,                                      ");
        sql.append("        tr.travelName,                                    ");
        sql.append("        re.employeeNo,                                    ");
        sql.append("        re.name,                                          ");
        sql.append("        re.money,                                         ");
        sql.append("        ro.roomNo,                                        ");
        sql.append("        ro.roomDetailNo,                                  ");
        sql.append("        de.deskNo,                                        ");
        sql.append("        de.deskDetailNo,                                  ");
        sql.append("        ve.vehicleNo,                                     ");
        sql.append("        ve.vehicleDetailNo                                ");
        sql.append("   FROM    (   (   (   registration re                    ");
        sql.append("                    INNER JOIN                            ");
        sql.append("                       travel tr                          ");
        sql.append("                    ON (re.travelNo = tr.travelNo))       ");
        sql.append("                LEFT OUTER JOIN                           ");
        sql.append("                   roommember ro                          ");
        sql.append("                ON     (re.travelNo = ro.travelNo)        ");
        sql.append("                   AND (re.employeeNo = ro.employeeNumber)");
        sql.append("                   AND (re.name = ro.MemberName))         ");
        sql.append("            LEFT OUTER JOIN                               ");
        sql.append("               deskmember de                              ");
        sql.append("            ON     (re.travelNo = de.travelNo)            ");
        sql.append("               AND (re.employeeNo = de.employeeNumber)    ");
        sql.append("               AND (re.name = de.memberName))             ");
        sql.append("        LEFT OUTER JOIN                                   ");
        sql.append("           vehiclemember ve                               ");
        sql.append("        ON     (re.travelNo = ve.travelNo)                ");
        sql.append("           AND (re.employeeNo = ve.employeeNumber)        ");
        sql.append("           AND (re.name = ve.memberName)                  ");
        sql.append("           AND (re.name = ve.memberName)                  ");
        sql.append("          ORDER BY    travelNo ,  employeeNo          ");
        ArrayList valueList = new ArrayList();
       
        return commonJB.query(sql.toString(), valueList);

    }

    /**
     * 根據所屬員工工號及其姓名取得該人員報名資料(可能是親友的報名資料)
     * 
     * @return
     */
    public Collection getJoinDetail(String employeeNo, String Name)
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT re.travelNo,                                      ");
        sql.append("        tr.travelName,                                    ");
        sql.append("        re.employeeNo,                                    ");
        sql.append("        re.name,                                          ");
        sql.append("        re.money,                                         ");
        sql.append("        ro.roomNo,                                        ");
        sql.append("        ro.roomDetailNo,                                  ");
        sql.append("        de.deskNo,                                        ");
        sql.append("        de.deskDetailNo,                                  ");
        sql.append("        ve.vehicleNo,                                     ");
        sql.append("        ve.vehicleDetailNo                                ");
        sql.append("   FROM    (   (   (   registration re                    ");
        sql.append("                    INNER JOIN                            ");
        sql.append("                       travel tr                          ");
        sql.append("                    ON (re.travelNo = tr.travelNo))       ");
        sql.append("                LEFT OUTER JOIN                           ");
        sql.append("                   roommember ro                          ");
        sql.append("                ON     (re.travelNo = ro.travelNo)        ");
        sql.append("                   AND (re.employeeNo = ro.employeeNumber)");
        sql.append("                   AND (re.name = ro.MemberName))         ");
        sql.append("            LEFT OUTER JOIN                               ");
        sql.append("               deskmember de                              ");
        sql.append("            ON     (re.travelNo = de.travelNo)            ");
        sql.append("               AND (re.employeeNo = de.employeeNumber)    ");
        sql.append("               AND (re.name = de.memberName))             ");
        sql.append("        LEFT OUTER JOIN                                   ");
        sql.append("           vehiclemember ve                               ");
        sql.append("        ON     (re.travelNo = ve.travelNo)                ");
        sql.append("           AND (re.employeeNo = ve.employeeNumber)        ");
        sql.append("           AND (re.name = ve.memberName)                  ");
        sql.append("  WHERE (re.employeeNo = ?)                               ");
        sql.append("   AND (re.name = ?)                                      ");
        ArrayList valueList = new ArrayList();
        valueList.add(employeeNo);
        valueList.add(Name);
        return commonJB.query(sql.toString(), valueList);

    }

    /**
     * 取得所有旅遊年份
     * 
     * @return
     */
    public Collection getAllTravelYear()
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct LEFT(travelNo, 4) year from travel t ");
        sql.append("    order by travelNo desc ");
        ArrayList valueList = new ArrayList();
        return commonJB.query(sql.toString(), valueList);

    }

    /**
     * 取得房間號碼
     * 
     * @param employeeNo
     * @param Name
     * @return
     */
    public String getRoomNO(String employeeNo, String Name)
    {
        String roomNO = "";
        Collection col = getJoinDetail(employeeNo, Name);
        if (col.size() > 0)
        {
            HashMap hm = null;
            hm = (HashMap) col.iterator().next();// 只會有一筆
            roomNO = strUtil.getPara(hm.get("roomNo"));

        }
        if(roomNO.equals(""))
        {
            System.err.println("==roomNO不存在====" +employeeNo+ " " +Name);
        }
        return roomNO;
    }

    public boolean isAdmin(String employeeNo)
    {
        boolean isAdmin = false;
        StringBuffer sql = new StringBuffer();
        sql.append("select * from admin where empNo = ? ");
        ArrayList valueList = new ArrayList();
        valueList.add(employeeNo);
        Collection col = commonJB.query(sql.toString(), valueList);
        if (col != null && col.size() > 0)
            isAdmin = true;

        return isAdmin;

    }

    public Collection getDisplayTravel()
    {

        StringBuffer sql = new StringBuffer();

        sql.append("SELECT *  FROM travel tr   where 1=1 ");
        sql.append("and DATE_FORMAT(current_date, '%Y/%m/%d') between tr.displayStartDate and tr.displayEndDate ");
        sql.append("order by tr.travelNo ");
        ArrayList valueList = new ArrayList();

        return commonJB.query(sql.toString(), valueList);

    }

    /**
     * 依旅程編號取得該旅程所有房間號碼
     * 
     * @param travelNo
     * @return
     */
    public Collection getRoomList(String travelNo)
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" select *  from room ");
        sql.append(" where 1=1 ");
        sql.append(" and travelNo = ? ");
        sql.append(" order by travelNo, roomNo ");

        ArrayList valueList = new ArrayList();
        valueList.add(travelNo);
        return commonJB.query(sql.toString(), valueList);
    }

    /**
     * 依旅程編號及房間號碼取得訂房人員
     * 
     * @param travelNo
     * @return
     */
    public Collection getMemberOfRoom(String travelNo, String roomNo)
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" select *  from roommember ");
        sql.append(" where 1=1 ");
        sql.append(" and travelNo = ? ");
        sql.append(" and roomNo = ? ");
        sql.append(" order by travelNo, roomNo ,roomDetailNo ");

        ArrayList valueList = new ArrayList();
        valueList.add(travelNo);
        valueList.add(roomNo);
        return commonJB.query(sql.toString(), valueList);
    }

    /**
     * 取得訂房人員，以字串回傳
     * 
     * @param roomNo
     * @return
     */
    public String getMemberNameOfRoom2String(String travelNo, String roomNo)
    {
        Collection col = getMemberOfRoom(travelNo, roomNo);
        Iterator it = col.iterator();
        HashMap hm = null;
        String str = "";
        while (it.hasNext())
        {
            hm = (HashMap) it.next();
            String MemberName = strUtil.getPara(hm.get("MemberName"));
            if (str.equals(""))
                str = MemberName;
            else
                str = str + "," + MemberName;

        }

        return str;
    }

    /**
     * 依旅程編號取得餐桌號碼
     * 
     * @param travelNo
     * @return
     */
    public Collection getDeskNO(String travelNo)
    {
        StringBuffer sql = new StringBuffer();
        sql.append("select *");
        sql.append("from desk ");
        sql.append("where 1=1 ");
        sql.append("and travelNo = ? ");
        sql.append("order by deskNo ");

        ArrayList valueList = new ArrayList();
        valueList.add(travelNo);
        return commonJB.query(sql.toString(), valueList);
    }

    /**
     * 依桌號取苃旅程編號取得餐桌號碼
     * 
     * @param travelNo
     * @return
     */
    public Collection getMemberOfDesk(String travelNo, String DeskNo)
    {
        StringBuffer sql = new StringBuffer();
        sql.append("select *");
        sql.append("from deskmember ");
        sql.append("where 1=1 ");
        sql.append("and travelNo = ? ");
        sql.append("and deskNo = ? ");
        sql.append("order by deskDetailNo ");

        ArrayList valueList = new ArrayList();
        valueList.add(travelNo);
        valueList.add(DeskNo);
        return commonJB.query(sql.toString(), valueList);
    }

    /**
     * 依旅程編號取得餐桌號碼，回傳字串
     * 
     * @param travelNo
     * @return
     */
    public String getMemberNameOfDesk2String(String travelNo, String DeskNo)
    {
        Collection col = getMemberOfDesk(travelNo, DeskNo);
        Iterator it = col.iterator();
        HashMap hm = null;
        String str = "";
        while (it.hasNext())
        {
            hm = (HashMap) it.next();
            String MemberName = strUtil.getPara(hm.get("memberName"));
            if (str.equals(""))
                str = MemberName;
            else
                str = str + "," + MemberName;

        }

        return str;

    }

    /**
     * 依旅程編號取取得車輛數量
     * 
     * @param travelNo
     * @return
     */
    public Collection getBusList(String travelNo)
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" select * ");
        sql.append(" from vehicle ");
        sql.append(" where 1=1 ");
        sql.append(" and travelNo = ? ");
        sql.append(" order by vehicleNo ");

        ArrayList valueList = new ArrayList();
        valueList.add(travelNo);
        return commonJB.query(sql.toString(), valueList);
    }
    
    /**
     * 依旅程編號，車號取得搭乘人員名單
     * 
     * @param travelNo
     * @return
     */
    public Collection getBusMemberList(String travelNo, String busNO)
    {
        StringBuffer sql = new StringBuffer();
        sql.append(" select * ");
        sql.append(" from vehiclemember ");
        sql.append(" where 1=1 ");
        sql.append(" and travelNo = ? ");
        sql.append(" and vehicleNo = ? ");
        sql.append(" order by vehicleDetailNo ");

        ArrayList valueList = new ArrayList();
        valueList.add(travelNo);
        valueList.add(busNO);
        return commonJB.query(sql.toString(), valueList);
    }
    
    /**
     * 依旅程編號，車號取得搭乘人員名單
     * 
     * @param travelNo
     * @return
     */
    public String  getBusMemberNameList2String(String travelNo, String busNO)
    {
        Collection col =  getBusMemberList(travelNo, busNO);
        Iterator it = col.iterator();
        HashMap hm = null;
        String str = "";
        while (it.hasNext())
        {
            hm = (HashMap) it.next();
            String MemberName = strUtil.getPara(hm.get("memberName"));
            if (str.equals(""))
                str = MemberName;
            else
                str = str + "," + MemberName;

        }

        return str;
    }

    /**
     * 依行程及房間床數來取得差價
     * 
     * @param travelNo
     * @param bedNum4room
     *            //房間型(4人床，2人床..)
     * @return money: 回傳價差金額
     */
    public int getRoomDiff(String travelNo, String bedNum4room)
    {
        travelNo = travelNo.trim();
        bedNum4room = bedNum4room.trim();
        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append("SELECT travelNo, two, three, four  ");
        sql.append("FROM roomfeedata ");
        sql.append("where 1=1 ");
        sql.append("and travelNo = ? ");
        valueList.add(travelNo);

        Collection col = commonJB.query(sql.toString(), valueList);
        HashMap hm = null;
        int money = 0;

        if (col.size() > 0)
        {
            hm = (HashMap) col.iterator().next();
            if (bedNum4room.equals("2"))
            {
                money = Integer.parseInt(strUtil.getPara(hm.get("two")));

            } else if (bedNum4room.equals("3"))
            {
                money = Integer.parseInt(strUtil.getPara(hm.get("three")));

            } else if (bedNum4room.equals("4"))
            {
                money = Integer.parseInt(strUtil.getPara(hm.get("four")));
            }

        }

        return money;

    }

    /**
     * 取得行程明細
     * 
     * @param travelNo
     * @return
     */
    public Collection getTravel(String[] para)
    {
        String travelNo = strUtil.getPara(para[0]);
        String year = strUtil.getPara(para[1]); // 選擇的行程年份
        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append("SELECT *  FROM travel tr   where 1=1 ");

        if (!travelNo.equals(""))
        {
            sql.append("and travelNo = ? ");
            valueList.add(travelNo);
        }

        if (!year.equals("") && !year.equals("All"))
        {
            sql.append("and left(travelDateStart, 4 ) = ? ");
            valueList.add(year);
        }

        return commonJB.query(sql.toString(), valueList);

    }

    /**
     * 取得該員工所有親屬資料
     * 
     * @param empNO
     * @return
     */
    public Collection getRelativesdata(String empNO)
    {

        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT *  FROM relativesdata tr   where 1=1 ");
        sql.append(" and employeeNumber = ? ");
        sql.append(" order by relatives ");

        valueList.add(empNO);

        return commonJB.query(sql.toString(), valueList);

    }

    /**
     * 取得該員工該員親屬資料
     * 
     * @param empNO
     * @return
     */
    public Collection getRelativesdata(String empNO, String name)
    {

        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT *  FROM relativesdata tr   where 1=1 ");
        sql.append(" and employeeNumber = ? ");
        sql.append(" and name = ? ");
        sql.append(" order by relatives ");

        valueList.add(empNO);
        valueList.add(name);

        return commonJB.query(sql.toString(), valueList);

    }

    /**
     * 不管該參加人員是員工本人或親屬，根據員工編號及姓名 ，取得其基本資料，
     * 
     * @param empNO
     * @return
     */
    public Collection getEmp2Relativesdata(String empNO, String name)
    {

        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT employeeNumber, relatives, name, idNumber, gender, age, birthday, address, room  ");
        sql.append(" FROM travel.relativesdata ");
        sql.append(" where 1=1  ");
        sql.append(" and employeeNumber = ? ");
        sql.append("  and trim(name) = ? ");
        sql.append(" union ");
        sql.append(" SELECT employeeNo, '員工', name, idNumber,  gender, age, birthday, address ,'1' ");
        sql.append(" FROM travel.personaldata ");
        sql.append(" where employeeNo = ? ");
        sql.append("  and trim(name) = ? ");
       

        valueList.add(empNO);
        valueList.add(name);
        valueList.add(empNO);
        valueList.add(name);

        return commonJB.query(sql.toString(), valueList);

    }
    
    
    
    /**
     * 取得員工個人資料
     * @param empNO
     * @return
     */
    public Collection getEmployeeBasicData(String empNO)
    {

        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT employeeNo, idNumber, name, gender, age, birthday, address  " );
        sql.append(" FROM travel.personaldata ");
        sql.append(" Where 1=1 ");
        sql.append(" and  employeeNo = ? ");
        valueList.add(empNO);
        return commonJB.query(sql.toString(), valueList);
      
    }
    
    
  

    /**
     * 取得該人員的年齡
     * 
     * @param empNO
     * @param name
     * @return
     * @throws Exception
     */
    public String getAge(String empNO, String name) throws Exception
    {
        String age = "";
      
        String birthday = getBirthday(empNO, name);
        DateUtil du = new DateUtil();
        System.out.println("取得年齡:" +empNO+ " ," +name+ ",birthday: " +birthday);
        age = String.valueOf(du.getAge(birthday));

        return age;
    }
    
    

    /**
     * 取得該人員的生日
     * 
     * @param empNO
     * @param name
     * @return
     */
    public String getBirthday(String empNO, String name)
    {
       
        Collection col = getEmp2Relativesdata(empNO, name);
        String birthday = null;
        HashMap hm = null;

        if (col.size() > 0) //只會有一筆資料
        {
            hm = (HashMap) col.iterator().next();
            birthday = strUtil.getPara(hm.get("birthday"));

        }
        //System.out.println("getBirthday======" +empNO+", " +name+ "," +birthday);
        return birthday;
    }
    
    /**
     * 取得該人員的的關係身分(員工/直系/親友)
     * 
     * @param empNO
     * @param name
     * @return
     */
    public String getRelative(String empNO, String name)
    {
       
        Collection col = getEmp2Relativesdata(empNO, name);
        String relatives = null;
        HashMap hm = null;

        if (col.size() > 0) //只會有一筆資料
        {
            hm = (HashMap) col.iterator().next();
            relatives = strUtil.getPara(hm.get("relatives"));

        }
        //System.out.println("getRelative======" +empNO+", " +name+ "," +relatives);
        return relatives;
    }

    /**
     * 取得該員工及親屬所有基本資料
     * 
     * @param empNO
     * @return
     */

    /**
     * 檢查是否已登記報名該行程
     * 
     * @param empNO
     * @return
     */
    public boolean isRegister(String TravelNo, String empNo)
    {

        boolean isResgister = false;
        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT count(*)  FROM registration   where 1=1 ");
        sql.append(" and travelNo = ? ");
        sql.append(" and employeeNo = ? ");
        valueList.add(TravelNo);
        valueList.add(empNo);

        Collection col = commonJB.query(sql.toString(), valueList);
        if (col.size() > 0)
            isResgister = true;

        return isResgister;

    }

    /**
     * 取得該行程報名人數
     * 
     * @param TravelNo
     * @return
     */
    public int getRegisterCount(String TravelNo)
    {

        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT *  FROM registration   where 1=1 ");
        sql.append(" and travelNo = ? ");

        valueList.add(TravelNo);
        Collection col = commonJB.query(sql.toString(), valueList);

        return col.size();

    }

    /**
     * 檢查該人員的報名紀錄
     * 
     * @param empNO
     * @return
     */
    public Collection getTravelData(String empNo, String name)
    {

        boolean isResgister = false;
        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT travelNo, employeeNo, name, temp, money, isTempFlag, writeDate ");
        sql.append(" FROM registration  ");
        sql.append(" where 1=1 ");
        sql.append(" and employeeNo = ? ");
        sql.append(" and name = ? ");
        valueList.add(empNo);
        valueList.add(name);

        return commonJB.query(sql.toString(), valueList);

    }

    /**
     * 根據人員，取得自費金額
     * 
     * @param empNo
     * @param name
     * @return
     * @throws Exception
     */
    public int getSelfPay(String empNo, String name) throws Exception
    {
        // 取得年齡及參加行程，找出所需自費的金額。
        DateUtil du = new DateUtil();
        boolean isResgister = false;
        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        String travleNo = getTravelNo(empNo, name);
        Collection col = getEmp2Relativesdata(empNo, name);
        int age = 0; // 年齡
        int SelfPay = 0; // 自費金額
        String relatives = "";  //取得關係，是公司員工或是親屬
        if (col.size() > 0)
        {
            HashMap hm = null;
            hm = (HashMap) col.iterator().next();
            String birthday = strUtil.getPara(hm.get("birthday"));
            age = du.getAge(birthday);
            relatives = strUtil.getPara(hm.get("relatives"));
        }
        //取得此行程的年齡繳費方式。
        sql.append(" SELECT travelNo,  rangeStart, rangeEnd, money ");
        sql.append(" FROM feedata  ");
        sql.append(" WHERE 1 = 1 ");
        sql.append("   AND travelNo = ? ");
        sql.append("   AND CAST(? AS UNSIGNED) BETWEEN rangeStart AND rangeEnd ");
        sql.append(" ORDER BY CAST(rangeStart AS UNSIGNED) ");

        valueList.add(travleNo);
        valueList.add(age);

        Collection col2 = commonJB.query(sql.toString(), valueList);
        if (col.size() > 0)
        {
            Iterator it2 = col2.iterator();
            HashMap hm2 = null;
            while (it2.hasNext())
            {
                hm2 = (HashMap) it2.next();
                SelfPay = Integer.parseInt(strUtil.getPara(hm2.get("money")));
            }
        }

        if (relatives.indexOf("員工") != -1) // 員工本人免費
        {
            SelfPay = 0;
        }

        String saveMoneyPeople = getSaveRelativePeople(empNo);
        System.out.println("比對親友================================" + name);
        System.out.println("補助最多的親友================================" + saveMoneyPeople);
        if (!saveMoneyPeople.equals("")) // 表示有找到補助最多的直系
        {
            if (name.equalsIgnoreCase(saveMoneyPeople)) // 符合要補助的直系。將自費額設為0
            {
                SelfPay = 0;
            }
        }

        return SelfPay;

    }

    /**
     * 若有直系親屬，找出補助金額最多的那一位親屬，若找不到，則傳回空字串
     * 
     * @param empNo
     * @return
     */
    public String getSaveRelativePeople(String empNo)
    {
        String name = "";
        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT re.travelNo, ra.*  ");
        sql.append("   FROM    relativesdata ra ");
        sql.append("        INNER JOIN   registration re ");
        sql.append("        ON (ra.employeeNumber = re.employeeNo) AND (ra.name = re.name) ");
        sql.append("  where re.employeeNo = ? ");
        sql.append("  and relatives = '直系' ");
        valueList.add(empNo);
        Collection col = commonJB.query(sql.toString(), valueList);
        Vector vec = new Vector();
        if (col.size() > 0) // 表示有直系親友
        {
            System.out.println("============有直系親友============");
            Iterator it = col.iterator();
            HashMap hm = null;
            while (it.hasNext())
            {
                hm = (HashMap) it.next();
                String age = strUtil.getPara(hm.get("age"));
                String travelNo = strUtil.getPara(hm.get("travelNo"));
                String money = getMoney4age(travelNo, age);
                HashMap hm2 = new HashMap();
                hm2.putAll(hm);
                hm2.put("momey", money);
                vec.add(hm2);
            }

            HashMap hm3;
            int maxMoney = 0; // 補助最多的金額
            int tmp = 0;
            HashMap maxMoneyHm = null;
            for (int i = 0; i < vec.size(); i++)
            {
                hm3 = (HashMap) vec.get(i);
                if (i == 0)
                    maxMoneyHm = hm3;
                tmp = Integer.parseInt(strUtil.getPara(hm3.get("momey")));
                if (tmp > maxMoney)
                {
                    maxMoneyHm = hm3;
                }
            }
            name = strUtil.getPara(maxMoneyHm.get("name"));

        }

        return name;

    }

    /**
     * 根據行程，年齡取得自費金額
     * 
     * @param travelNo
     * @param age
     * @return
     */
    public String getMoney4age(String travelNo, String age)
    {
        String name = "";
        String money = "0";
        StringBuffer sql = new StringBuffer();
        ArrayList valueList = new ArrayList();
        sql.append(" SELECT travelNo,  rangeStart, rangeEnd, money ");
        sql.append(" FROM feedata  ");
        sql.append(" WHERE 1 = 1 ");
        sql.append("   AND travelNo = ? ");
        sql.append("   AND CAST(? AS UNSIGNED) BETWEEN rangeStart AND rangeEnd ");
        sql.append(" ORDER BY CAST(rangeStart AS UNSIGNED) ");
        valueList.add(travelNo);
        valueList.add(age);
        Collection col = commonJB.query(sql.toString(), valueList);
        if (col.size() > 0)
        {
            Iterator it = col.iterator();
            HashMap hm = (HashMap) it.next(); // 只有一筆資料

            money = strUtil.getPara(hm.get("money"));

        }

        return money;

    }

    /**
     * 取得該人員的報名行程代碼
     * 
     * @param empNo
     * @param name
     * @return
     */
    public String getTravelNo(String empNo, String name)
    {

        String travelNO = "";
        Collection col = getTravelData(empNo, name);
        HashMap hm = null;
        if (col.size() > 0)
        {
            hm = (HashMap) col.iterator().next(); // 只會有一筆資料
            travelNO = strUtil.getPara(hm.get("travelNo"));
        }
        return travelNO;
    }

    /**
     * 取得該人員所需繳交總金額
     * 
     * @param empNo
     * @param name
     * @return
     */
    public int getMoney(String empNo, String name) throws Exception
    {
        int payMoney = 0;

        Iterator it = null;
        int roomPay = 0; // 房間額外費用
        int selfPay = 0; // 自費金額
        System.out.println("getMONey============" +empNo+ ", " +name);
        roomPay = getRoomPay(empNo, name);
        selfPay = getSelfPay(empNo, name);
        System.out.println("room:" + roomPay);
        System.out.println("selfPay:" + roomPay);

        payMoney = roomPay + selfPay;
        return payMoney;

    }

    /**
     * 根據人員資料取得房間費用
     * 
     * @param empNo
     * @param name
     * @return
     */
    public int getRoomPay(String empNo, String name)
    {
        // 先檢查佔不佔床，若不佔床，就沒有房間費。
        int roompay = 0;  //所需付的房間費
        System.out.println("==============getRoomPay:" +empNo+ ", " +name);
        Collection col = getEmp2Relativesdata(empNo, name);
        HashMap hm = null;
        String needRoom = null;
        if (col.size() != 0)
        {
             System.out.println("有基本資料....... " );
            Iterator it = col.iterator();
            hm = (HashMap) it.next(); // 只要有一筆資料
            needRoom = strUtil.getPara(hm.get("room"));
            // System.out.println("needRoom===== " +needRoom);
            if (needRoom.equals("1")) // 需佔床，計算房間費
            {

                String travelNo = getTravelNo(empNo, name);
                // System.out.println("travelNo===== " +travelNo);
                String roomNO =  getRoomNO(empNo, name);
                if(!roomNO.equals("")) 
                {
                   //有訂房間
                    String roomType = getRoomNO(empNo, name).substring(0, 1); // 4:代表4人房，2代表2人房...
                    roompay = getRoomDiff(travelNo, roomType); 
                   
                }   
            }

        }

        return roompay;

    }

}
