package library.beans;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//데이터베이스 관련된 유용한 작업들을 수행
public class JdbcUtils {

	//연결 기능
	//= 테이블 종류와 무관하게 전체적으로 이용해야 하므로 객체 생성 없이 쉽게 접근하도록 정적(static) 등록
	public static Connection getConnection(String username, String password) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe", username, password);
		return con;
	}
	
	private static DataSource ds;
	static {
		try {
			// 1. 자원 탐색 도구를 생성한다(InitialContext)
			Context ctx = new InitialContext();
			// 2. 경로를 식으로 알려주고 탐색을 명한다
			ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/oracle");
			// ds = context.xml에 등록된 <Resource> 중에서 jdbc/oracle이름을 가진 도구

		} catch (Exception e) {
			System.err.println("데이터베이스 연결 실패");
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws Exception {
		return ds.getConnection();
	}
}