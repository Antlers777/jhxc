//
//  FMDBManager.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/29.
//

import Foundation

// 数据库管理类
class SQLiteManager: NSObject {
    
    // 创建单例
    private static let manger: SQLiteManager = SQLiteManager()
    class func shareManger() -> SQLiteManager {
        return manger
    }
    
    // 数据库名称
    private let dbName = "jhxc.db"
    
    // 数据库地址
    lazy var dbURL: URL = {
        // 根据传入的数据库名称拼接数据库的路径
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask,
                 appropriateFor: nil, create: true)
            .appendingPathComponent(dbName)
        print("数据库地址：", fileURL)
        return fileURL
    }()
    
    // FMDatabase对象（用于对数据库进行操作）
    lazy var db: FMDatabase = {
        let database = FMDatabase(url: dbURL)
        return database
    }()
    
    // FMDatabaseQueue对象（用于多线程事务处理）
    lazy var dbQueue: FMDatabaseQueue? = {
        // 根据路径返回数据库
        let databaseQueue = FMDatabaseQueue(url: dbURL)
        return databaseQueue
    }()
    
    
    // 创建表
    func createTable() {
        let sql = "CREATE TABLE IF NOT EXISTS Mark( \n" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
            "name TEXT, \n" +
            "info TEXT, \n" +
            "type INTEGER, \n" +
            "point TEXT \n" +
            "); \n"
        let db = SQLiteManager.shareManger().db
        if db.open() {
            if db.executeUpdate(sql, withArgumentsIn: []) {
                print("创建表成功")
            } else {
                print("创建表失败")
            }
        }
        db.close()
    }
    
    func insertMark(name: String, info: String, type: Int, point: String) {
        let sql = "INSERT INTO Mark(name,info,type,point) VALUES('\(name)','\(info)','\(type)','\(point)');"
    }
    
}
