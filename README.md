# PharoADO 


PharoADO enables data persistence in Pharo by using ActiveX Data Objects (ADO) on Microsoft Windows and external DBMS. It consists of two packages:
- PharoADO: this package reflects the most used ADO objects - ADOConnection, ADORecordset, ADOFields and ADOField. It also includes ADOClient class to make the communication with the database as simple as possible.
- PharoADO-Glorp implements ADODatabaseDriver to be used as a Glorp database driver.  

ADO comprises a set of Component Object Model (COM) objects to access various data sources. ADO is mature middleware technology and can be used as an abstraction between the application and database layers. It supports a plethora of various DBMSs and data providers.

Since ADO is based on Component Object Model (COM), PharoADO relies on PharoCOM and other packages in PharoWin32 repository (https://github.com/tesonep/pharo-com).

This repository is a prototype. Please test it in your own environments, especially by:
- different DBMS endpoints (e.g. SQL Server, Oracle, MySQL, SQLite)
- using various data providers (e.g. ODBC, native clients)
- trying out various database data types.

Our goal is to provide a reliable technology for data persistence with Pharo, ADO, Glorp and DBMSs and to promote Pharo in this kind of setups.

Please tell us your experiences on Pharo mailing lists (http://forum.world.st), report issues on GitHub, and contribute by PRs.


## Code loading

The default group loads both packages (PharoADO and PharoADO-Glorp), together with Glorp and PharoWin32:

```smalltalk
Metacello new
  baseline: 'PharoADO';
  repository: 'github://eftomi/pharo-ado';
  load.
```

If you don't need support for Glorp, you can load just the PharoADO like this:

```smalltalk
Metacello new
  baseline: 'PharoADO';
  repository: 'github://eftomi/pharo-ado';
  load: 'pharo-ado'.
```


## Usage 

The usage can be seen from test examples in ADOClientTests (package PharoADO). Examples of Glorp & PharoADO usage are available in ExampleTestOracle and ExampleTestSQLServer within PharoADO-Glorp package.



### ADOClient 

ADOClient enables for the most basic usage of the package. Here's an exaple of a simple SELECT query:

```smalltalk
c := ADOClient new 
  connectString: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;';
  user: '';
  password: ''.
c open.
c query: 'SELECT * FROM PERSON'.
c close.
```

If we issue the above #query: selector, the command is sent to the database by using ADO Connection's Execute() method. The return value is an array of rows, each row is an array of field values. Besides SELECT queries, we can use INSERT INTO, UPDATE, DELETE and DDL commands. The communication with different databases through various data providers can be achieved by different connection strings.

### ADOConnection, ADORecordset

Traditional ADO Connection and Recordset objects can be used in the following way:

```smalltalk
conn := ADOConnection createInstance .
conn 
  open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;' 
  user: '' 
  password: ''.
rst := ADORecordset createInstance .
rst open: 'SELECT * FROM PERSON' activeConnection: conn cursorType: 2 lockType: 3 options: -1.

rst addNew.
(rst fields item: 2) value: 'John'.
(rst fields item: 3) value: 'Kay'.
(rst fields item: 4) value: 'johnkay@somedomain.org'.
(rst fields item: 5) value: '1979-05-12'.
rst update.

rst moveFirst.

[rst eof] whileFalse: [ 
  1 to: rst fields count do: [ :idx |
    Transcript show: (rst fields item: idx) name; show: ':'; 
               show: (rst fields item: idx) value; cr].
    Transcript cr.
    rst moveNext ].

rst close.
conn close.
```

The database table in the example is from the Glorp book (Maringolo et al. (2018) Object-Relational Persistence with Glorp).

### PharoADO-Glorp

The usage of PharoADO-Glorp is pretty much defined by Glorp itself. To use the ADODatabaseDriver, one has to establish Pharo database accessor and declare a proper database platform, like in:

```smalltalk
PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

login := Login new
  database: OraclePlatform new;
  connectString: 'Driver={Oracle in instantclient_19_3};dbq=localhost:1521/XE;Uid=c##pharo;Pwd=pharo;';
  username: '';
  password: '';
  yourself.

session := ExampleDescriptorSystem sessionForLogin: login.
session login.
```

The above is an example for Oracle. SQL Server differs only in the database platform choice:

```smalltalk
PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

login := Login new
  database: SQLServerPlatform new;
  connectString: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;';
  username: '';
  password: '';
  yourself.

session := ExampleDescriptorSystem sessionForLogin: login.
session login.
```

When Glorp writes data onto DBMS, it "serializes" it by means of SQL commands according to the corresponding database platform. When receiving query results, the data transformation is done by ADORecordset object, more precisely by PharoCOM. A diversity of data types that can be used thus depends from their definition in Glorp/DatabasePlatform itself and PharoCOM implementation.

