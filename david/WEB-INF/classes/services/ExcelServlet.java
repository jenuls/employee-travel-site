package services;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.*;
import jxl.write.*;
import jxl.write.biff.RowsExceededException;

import myutil.DateUtil;
import myutil.strUtil;

import connect.TravelBean;

/**
 * Servlet implementation class ExcelServlet
 */
public class ExcelServlet extends HttpServlet
{
      private static final long serialVersionUID = 1L;

      /**
       * @see HttpServlet#HttpServlet()
       */
      public ExcelServlet()
      {
            super();

      }

      /**
       * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
       */
      protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
      {
            doPost(request, response);
      }

      /**
       * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
       */
      protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
      {
            System.out.println("測試servlet======================");
            String action = request.getParameter("action");
            if (action.equals("registerReport"))
            {
                  registerReport(request, response);
            }
      }

      /**
       * 產生報名資料費用的excel報表
       * 
       * @param request
       * @param response
       * @throws ServletException
       * @throws IOException
       */
      private void registerReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
      {
            String travelNo = request.getParameter("travelNo");
            String travelName = "";
            // 設定excel
            response.reset();
            response.setHeader("Content-disposition", "attachment; filename=" + travelNo + ".xls");
            OutputStream os = response.getOutputStream();

            // 產生一檔案讓程式匯出
            // WritableWorkbook writableWorkBook = Workbook.createWorkbook(new
            // File("d:\\text.xls"));
            WritableWorkbook writableWorkBook = Workbook.createWorkbook(os);
            // 在檔案中開啟一新的WorkBook
            WritableSheet writableSheet = writableWorkBook.createSheet("明細表", 1);
            // 設定寫入儲存格的字型大小
            WritableFont chFont12w = new WritableFont(WritableFont.createFont("新細明體"), 12);
            WritableCellFormat writableCellFormat = new WritableCellFormat(chFont12w);

            // 設定cell寬度
            writableSheet.setColumnView(0, 15);
            writableSheet.setColumnView(1, 35);
            writableSheet.setColumnView(2, 15);
            writableSheet.setColumnView(3, 15);
            writableSheet.setColumnView(4, 10);
            writableSheet.setColumnView(5, 15);
            writableSheet.setColumnView(6, 10);
            writableSheet.setColumnView(7, 15);
            writableSheet.setColumnView(8, 15);
            writableSheet.setColumnView(9, 15);
            writableSheet.setColumnView(10, 15);
            writableSheet.setColumnView(11, 15);
            writableSheet.setColumnView(12, 10);

            try
            {
                  // 寫入儲存格A1
                  Label label = new Label(0, 0, "行程代碼", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(1, 0, "行程名稱", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(2, 0, "工號", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(3, 0, "姓名", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(4, 0, "關係", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(5, 0, "身分證字號", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(6, 0, "年齡", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(7, 0, "生日", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(8, 0, "房間", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(9, 0, "餐桌", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(10, 0, "車輛", writableCellFormat);
                  writableSheet.addCell(label);
                  label = new Label(11, 0, "費用", writableCellFormat);
                  writableSheet.addCell(label);

                  // 抓取資料，寫入excel
                  TravelBean bean = new TravelBean();
                  Collection col = bean.getJoinDetail2();
                  Iterator it = col.iterator();
                  HashMap hm = null;
                  HashMap hm2 = null;
                  int row = 1;
                  while (it.hasNext())
                  {
                        hm = (HashMap) it.next();
                        travelName = strUtil.getPara(hm.get("travelName"));
                        String employeeNo = strUtil.getPara(hm.get("employeeNo"));
                        String name = strUtil.getPara(hm.get("name"));
                        String roomNo = strUtil.getPara(hm.get("roomNo")); // 房間號碼
                        String roomDetailNo = strUtil.getPara(hm.get("roomDetailNo")); // 床位號碼
                        String deskNo = strUtil.getPara(hm.get("deskNo")); // 桌號
                        String deskDetailNo = strUtil.getPara(hm.get("deskDetailNo")); // 桌位
                        String vehicleNo = strUtil.getPara(hm.get("vehicleNo")); // 車號
                        String vehicleDetailNo = strUtil.getPara(hm.get("vehicleDetailNo")); // 車位
                        int pay = 0;
                        try
                        {
                              pay = bean.getMoney(employeeNo, name); // 費用
                        } catch (Exception e1)
                        {
                              pay = -1;
                              System.out.println("取得個人總金額發生問題");
                              e1.printStackTrace();
                        }

                        Collection<String> col2 = bean.getEmp2Relativesdata(employeeNo, name);
                        String age = "";
                        String relatives = "";
                        String idNumber = "";
                        String birthday = "";
                        Iterator it2 = col2.iterator();
                        while (it2.hasNext())
                        {
                              hm2 = (HashMap) it2.next();
                              relatives = strUtil.getPara(hm2.get("relatives"));
                              idNumber = strUtil.getPara(hm2.get("idNumber"));
                              birthday = strUtil.getPara(hm2.get("birthday"));
                              try
                              {
                                    age = String.valueOf(DateUtil.getAge(birthday));

                              } catch (ParseException e)
                              {
                                    System.out.println("出生日期格式有誤");
                                    age = "";
                                    e.printStackTrace();
                              }

                        } // end of while (it2.hasNext())

                        label = new Label(0, row, travelNo, writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(1,  row,  travelName, writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(2,  row, employeeNo, writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(3,  row, name, writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(4,  row, relatives, writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(5,  row, idNumber, writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(6,  row, age, writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(7,  row, birthday, writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(8,  row, roomNo+ "【" + roomDetailNo + "】", writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(9,  row, deskNo+ "【" + deskDetailNo+ "】", writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(10,  row, vehicleNo+ "【" + vehicleDetailNo + "】", writableCellFormat);
                        writableSheet.addCell(label);
                        label = new Label(11,  row  , String.valueOf(pay)  , writableCellFormat);
                        writableSheet.addCell(label);
                       row++;

                  }  //end of while (it.hasNext())
                  writableWorkBook.write();
                  writableWorkBook.close();
                  os.flush();
                  os.close();
           
            } catch (RowsExceededException e)
            {
                  System.out.println("下載 旅遊報名資料excel報表，發生錯誤:"  +travelNo+ ": "   +travelName);
                  e.printStackTrace();
                  
                  response.reset();
                  response.setContentType("text/html; charset=utf-8");
                  PrintWriter pw = response.getWriter();
                  pw.write("<script>alert('產生報表發生問題，請連絡系統管理員')</script>");
                  pw.flush();
               
            } catch (WriteException e)
            {
                  System.out.println("下載 旅遊報名資料excel報表，發生錯誤:"  +travelNo+ ": " + travelName);
                  e.printStackTrace();
                  
                  response.reset();
                  response.setContentType("text/html; charset=utf-8");
                  PrintWriter pw = response.getWriter();
                  pw.write("<script>alert('產生報表發生問題，請連絡系統管理員')</script>");
                  pw.flush();
            }

      }

}
