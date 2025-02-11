package com.corteza.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConfig {

    private static String dbURL = "";
    private static String userName = "";
    private static String password = "";

    private static DBConfig dbConfig;

    private static String DB_PROPERTIES_FILE = "db.properties";

    private static final Logger logger = LoggerFactory.getLogger(DBConfig.class);

    private DBConfig(){
        Properties properties = new Properties();
        try (InputStream input = getClass().getResourceAsStream("/WEB-INF/classes/db.properties")) {
            if (input == null) {
                logger.error("File not found");
            }
            properties.load(input);

            // Retrieve the database properties
             dbURL = properties.getProperty("mysql.db.url");
             userName = properties.getProperty("mysql.db.username");
            password = properties.getProperty("mysql.db.password");
        }catch (Exception ex){
            logger.error("Error in reading db properties {}",ex);
        }

    }

    public static Connection getConnection(){
            if(dbConfig==null){
                dbConfig = new DBConfig();
            }
        return dbConfig.createDbConnection();


    }

    private Connection createDbConnection(){
        Connection connection = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
             connection = DriverManager.getConnection(dbURL,userName,password);
        }catch (Exception e) {
            logger.error("ERROR in making the connection {}", e);

        }
        return connection;
    }
}
