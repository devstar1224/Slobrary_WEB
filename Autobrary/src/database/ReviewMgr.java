package database;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bucketConnector.BucketManager;
import database.DBConnectionMgr;

public class ReviewMgr {
	private DBConnectionMgr pool = null;

    public ReviewMgr() {
        try {
            pool = DBConnectionMgr.getInstance();
        } catch (Exception e) {
            System.out.println("Error !!");
        }
    }
    
    public Vector getReportList(String mem_id, String type) {
    	Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Vector vecList = new Vector();
        String strQuery = "";
     
        try {
            con = pool.getConnection(); 
            if(type.equals("all")) {
            	strQuery = "select * from book_report ";
            	pstmt = con.prepareStatement(strQuery);
            }else if(type.equals("mem")) {
            	strQuery = "select * from book_report where mem_id = ? ";
            	pstmt = con.prepareStatement(strQuery);
            	pstmt.setString(1, mem_id);
            }
            
            rs = pstmt.executeQuery();
            while (rs.next()) {     	 
            	 ReportBean reportBean = new ReportBean();
            	 reportBean.setBook_id(rs.getString("book_id"));
            	 reportBean.setMem_id(rs.getString("mem_id"));
            	 reportBean.setReport_id(rs.getString("report_id"));
            	 reportBean.setName(rs.getString("name"));
            	 reportBean.setContent(rs.getString("content"));
            	 reportBean.setReport_date(rs.getString("report_date"));
            	 reportBean.setLocked(rs.getString("locked"));

                 vecList.add(reportBean);
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return vecList;
    }
    
    public RatingBean getRating(String book_id) {
    	Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        RatingBean ratingBean = null;

        try {
            con = pool.getConnection();
            String strQuery = "select * " + 
            		"from rating_info " + 
            		"where book_id = ? ";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, book_id);
            rs = pstmt.executeQuery();
            while (rs.next()) {     	 
            	ratingBean = new RatingBean();
            	ratingBean.setBook_id(rs.getString("book_id"));
            	ratingBean.setAll_score(rs.getString("all_score"));
            	ratingBean.setCount(rs.getString("count"));
            	ratingBean.setRating(rs.getString("rating"));   	      
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return ratingBean;
    }
    
    
    public boolean insertReview(String mem_id, String book_id, String content, String rating) {
    	Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        String sql = "INSERT INTO review(mem_id, book_id, content, rating) "
        		+ "VALUES (?, ?, ?, ?) ";
        String sql_ = "UPDATE rating_info SET all_score = ?, count = ?, rating = ? WHERE book_id = ? ";
        try {
        	con = pool.getConnection();
        	pstmt = con.prepareStatement(sql);
        	pstmt.setString(1, mem_id);	
        	pstmt.setString(2, book_id);
        	pstmt.setString(3, content);
        	pstmt.setString(4, rating);
            int count = pstmt.executeUpdate();
            if (count == 1) {
                flag = true;
            }
        }catch (Exception ex) {//
            System.out.println("Exception" + ex);
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return flag;
    }
    
    public boolean updateRating(String book_id, String all_score, String count, String rating) {
    	Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        String sql = "UPDATE rating_info SET all_score = ?, count = ?, rating = ? WHERE book_id = ? ";
        try {
        	con = pool.getConnection();
        	pstmt = con.prepareStatement(sql);
        	pstmt.setString(1, all_score);	
        	pstmt.setString(2, count);
        	pstmt.setString(3, rating);
        	pstmt.setString(4, book_id);
            int count_ = pstmt.executeUpdate();
            if (count_== 1) {
                flag = true;
            }
        }catch (Exception ex) {//
            System.out.println("Exception" + ex);
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return flag;
    }

}