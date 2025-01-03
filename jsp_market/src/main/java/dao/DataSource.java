package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataSource {
    private static DataSource instance;
    private String url = "jdbc:mysql://192.168.30.8:3306/jsp_market?serverTimezone=Asia/Seoul&allowPublicKeyRetrieval=true&useSSL=false";
    private String username = "admin";
    private String password = "passwd";

    // private 생성자
    private DataSource() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC 드라이버 로드
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // 싱글톤 인스턴스 가져오기
    public static synchronized DataSource getInstance() {
        if (instance == null) {
            instance = new DataSource();
        }
        return instance;
    }

    // 데이터베이스 연결 가져오기
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}


