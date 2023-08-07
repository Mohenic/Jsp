package kr.co.jboard1.dao;

import java.util.List;

import kr.co.jboard1.db.DBHelper;
import kr.co.jboard1.db.SQL;
import kr.co.jboard1.vo.ArticleVO;

public class ArticleDAO extends DBHelper {

	// 기본 CRUD
	public void insertArticle(ArticleVO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.INSERT_ARTICLE);
			psmt.setString(1, vo.getTitle());
			psmt.setString(2, vo.getContent());
			psmt.setString(3, vo.getWriter());
			psmt.setString(4, vo.getRegip());
			psmt.executeUpdate();
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public ArticleVO selectArticle(int no) {
		return null;
	}
	public List<ArticleVO> selectArticles() {
		return null;
	}
	public void updateArticle(ArticleVO vo) {
		
	}
	public void deleteArticle(int no) {
		
	}
}
