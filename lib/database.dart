import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// import 'Product.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    // Directory documentsDirectory = await
    // getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), "PPdb.db");
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Login ("
          "UserName TEXT NOT NULL UNIQUE,"
          "Password TEXT NOT NULL,"
          "UserId INTEGER PRIMARY KEY AUTOINCREMENT"
          ")");
      await db.execute("CREATE TABLE  Account("
          "UserId INTEGER UNIQUE,"
          "AccountNo INTEGER PRIMARY KEY,"
          "Balance REAL DEFAULT 0.0,"
          "FOREIGN KEY(UserId) REFERENCES Login(UserId)"
          ")");
      await db.execute("CREATE TABLE  CreditCard("
          "AccountNo INTEGER ,"
          "CardNo INTEGER PRIMARY KEY,"
          "ExpiryDate TEXT,"
          "CVV INTEGER NOT NULL ,"
          "CardType TEXT NOT NULL ,"
          "FOREIGN KEY(AccountNo) REFERENCES Account(AccountNo)"
          ")");
      await db.execute(
          "INSERT INTO Login ('UserName', 'Password')"
          "values (?,?)",
          ["Penta Pals", "123"]);
      await db.execute(
          "INSERT INTO Account "
          "values (?,?,?)",
          [1, 12345678, 10000.0]);
      await db.execute(
          "INSERT INTO CreditCard "
          "values (?,?,?,?,?)",
          [12345678, 100000000, "5/22", 000, "Visa"]);
    });
  }

  Future<List<Map>> getLoginDetails(String uname, String password) async {
    final db = await database;
    var result = await db.query("Login",
        where: "UserName = \"$uname\" AND Password=\"$password\"");
    //var result = await db.query("Login");
    return result.isNotEmpty ? result : [];
  }

  Future<List<Map>> getAccountDetails(int userId) async {
    final db = await database;
    // var result = await db.query("Account");
    var result = await db.rawQuery(
        "SELECT Login.UserName,Account.AccountNo,Account.Balance "
        "FROM Account Inner Join Login "
        "On Account.UserId=Login.UserId "
        "WHERE Account.UserId=?",
        [userId]);
    print(userId);
    //var result = await db.query("Login");
    return result.isNotEmpty ? result : [];
  }

  Future<List<Map>> getCardDetails(int cardNo) async {
    final db = await database;
    // var result = await db.query("Account");
    var result = await db.rawQuery(
        "SELECT Login.UserName,CreditCard.CardNo,Account.Balance,"
        " CreditCard.ExpiryDate,CreditCard.CVV "
        "FROM CreditCard INNER JOIN Account "
        "On Account.AccountNo=CreditCard.AccountNo "
        "INNER JOIN Login "
        "ON Account.UserId=Login.UserId "
        "WHERE CreditCard.CardNo=?",
        [cardNo]);
    print(cardNo);
    //var result = await db.query("Login");
    return result.isNotEmpty ? result : [];
  }

  Future<List<Map>> displayAllCards(int accountNo) async {
    final db = await database;
    // var result = await db.query("Account");
    var result = await db.rawQuery(
        "SELECT * "
        "FROM CreditCard  "
        "Where AccountNo=?",
        [accountNo]);
    print(accountNo);
    //var result = await db.query("Login");
    return result.isNotEmpty ? result : [];
  }

  Future<List<Map>> getAllUsers(int userId) async {
    final db = await database;
    // var result = await db.query("Account");
    var result = await db.rawQuery(
        "SELECT Login.UserName,Account.AccountNo,Login.UserId "
        "FROM Account INNER JOIN Login "
        "ON Account.UserId=Login.UserId "
        "Where Account.UserId!=?",
        [userId]);
    return result.isNotEmpty ? result : [];
  }

  Future<int> insertLogin(String username, String password) async {
    final db = await database;
    var result = await db.rawInsert(
        "INSERT Into Login (UserName, Password)"
        " VALUES (?, ?)",
        [username, password]);
    return result;
  }

  Future<int> createAccount(int userId, int accountNo) async {
    final db = await database;
    var result = await db.rawInsert(
        "INSERT Into Account "
        " VALUES (?,?, ?)",
        [userId, accountNo, 100.0]);
    return result;
  }

  generateCard(int accountNo, int cardNo, String expiry, int cvv,
      String cardType) async {
    final db = await database;
    var result = await db.rawInsert(
        "INSERT Into CreditCard "
        " VALUES (?,?,?, ?,?)",
        [accountNo, cardNo, expiry, cvv, cardType]);
    return result;
  }

  Future<bool> checkAccountExist(int accountNo) async {
    final db = await database;
    var queryResult =
        await db.rawQuery('SELECT * FROM Account WHERE AccountNo=$accountNo');
    return queryResult.isNotEmpty ? true : false;
  }

  Future<bool> checkCardExist(int cardNo) async {
    final db = await database;
    var queryResult =
        await db.rawQuery('SELECT * FROM CreditCard WHERE CardNo=$cardNo');
    return queryResult.isNotEmpty ? true : false;
  }

  debitAmount(int cardNo, double balance) async {
    final db = await database;
    var getAccount = await db.rawQuery(
        "SELECT AccountNo From CreditCard "
        "WHERE CardNo=?",
        [cardNo]);
    var result = await db.rawUpdate(
        "UPDATE Account SET Balance = ?"
        " WHERE AccountNo = ?",
        [balance, getAccount[0]["AccountNo"]]);
    print(result);
    return result;
  }

  creditAmount(String name, double add) async {
    final db = await database;
    var getAccount = await db.rawQuery(
        "SELECT Account.AccountNo,Account.Balance "
        "From Login INNER JOIN Account "
        "ON Account.UserId=Login.UserId "
        "WHERE Login.UserName=?",
        [name]);
    var result = await db.rawUpdate(
        "UPDATE Account SET Balance = ?"
        " WHERE AccountNo = ?",
        [getAccount[0]["Balance"] + add, getAccount[0]["AccountNo"]]);
    print(result);
    return result;
  }
}
