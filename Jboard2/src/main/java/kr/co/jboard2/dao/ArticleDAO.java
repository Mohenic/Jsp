package kr.co.jboard2.dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.SQL;
import kr.co.jboard2.dto.ArticleDTO;

public class ArticleDAO extends DBHelper {


	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public int insertArticle(ArticleDTO dto) {
		
		int no = 0;
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false); // Transaction 시작
			
			stmt = conn.createStatement();
			psmt = conn.prepareStatement(SQL.INSERT_ARTICLE);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setInt(3, dto.getFile());
			psmt.setString(4, dto.getWriter());
			psmt.setString(5, dto.getRegip());
			psmt.executeUpdate();
			rs = stmt.executeQuery(SQL.SELECT_MAX_NO);
			conn.commit(); // 작업확정
			
			if(rs.next()) {
				no = rs.getInt(1);
			}
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return no;
	}
	
	public ArticleDTO selectArticle(int no) {
		return null;
	}
	
	public List<ArticleDTO> selectArticles(int start) {
		
		List<ArticleDTO> articles = new ArrayList<>();
		
		try{
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ARTICLES);
			psmt.setInt(1, start);
			rs = psmt.executeQuery();
			
			while(rs.next()){
				ArticleDTO article = new ArticleDTO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setWriter(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11));
				article.setNick(rs.getString(12));
				articles.add(article);			
			}
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return articles;
	}
	
	public void updateArticle(ArticleDTO dto) {
		
	}
	
	public void deleteArticle(int no) {
		
	}
	
	public int selectCountTotal() {
		int total = 0;
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();			
			rs = stmt.executeQuery(SQL.SELECT_COUNT_TOTAL);
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			close();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return total;
	}
	
}
