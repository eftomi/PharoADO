Class {
	#name : #ADOClientTests,
	#superclass : #TestCase,
	#category : #'PharoADO-Tests'
}

{ #category : #tests }
ADOClientTests >> testCreateTable [
	| conn |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;;' 
		user: '' 
		password: ''.

	conn execute: 'CREATE TABLE [dbo].[myTable]
		(
			[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
			[Description] NVARCHAR(50) NULL, 
			[Date] DATE NULL, 
			[DecimalValue] DECIMAL(18, 2) NULL, 
			[FloatValue] FLOAT NULL
		)'.
	conn close.

]

{ #category : #tests }
ADOClientTests >> testDelete [
	| conn rst  |
	conn := ADOConnection createInstance.
	conn
		open:
			'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;AutoTranslate=true;'
		user: ''
		password: ''.
	rst := ADORecordset createInstance.
	rst
		open: 'SELECT * FROM [dbo].[myTable]'
		activeConnection: conn
		cursorType: 2
		lockType: 3
		options: -1.

	rst addNew.
	(rst fields item: 2) value: 'This is unimportant record'.
	rst update.
	(rst fields item: 2) value inspect.
	rst movePrevious; moveNext .
	rst delete.

	rst close.
	conn close
]

{ #category : #tests }
ADOClientTests >> testInsert [
	| conn rst data |
	conn := ADOConnection createInstance.
	conn
		open:
			'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;AutoTranslate=true;'
		user: ''
		password: ''.
	rst := ADORecordset createInstance.
	rst
		open: 'SELECT * FROM [dbo].[myTable]'
		activeConnection: conn
		cursorType: 2
		lockType: 3
		options: -1.

	rst addNew.
	data := {'#Id'. 'This is new record'. Date today. 12345. 12345 }.
	2 to: rst fields count do: [ :idx | (rst fields item: idx) value: (data at: idx) ].
	rst update.

	rst close.
	conn close
]

{ #category : #tests }
ADOClientTests >> testNull [
	| conn rst data |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;;' 
		user: '' 
		password: ''.

	rst := conn execute: 'SELECT @@IDENTITY'.
	data := (rst fields item: 1) value.

	rst close.
	conn close.

]

{ #category : #tests }
ADOClientTests >> testRstInsertOracle [
	| conn rst rstNextVal |
	conn := ADOConnection createInstance .
	conn 
		open: 'Driver={Oracle in instantclient_19_3};dbq=localhost:1521/XE;Uid=c##pharo;Pwd=pharo;' 
		user: '' 
		password: ''.
	rst := ADORecordset createInstance .
	rstNextVal := ADORecordset createInstance .
	rstNextVal open: 'SELECT PERSON_ID_SEQ.NEXTVAL FROM DUAL' activeConnection: conn cursorType: 3 lockType: 1 options: -1.
	rst open: 'SELECT * FROM PERSON' activeConnection: conn cursorType: 2 lockType: 3 options: -1.

	rst addNew.
	(rst fields item: 1) value: (rstNextVal fields item: 1) value asInteger.
	(rst fields item: 2) value: 'John'.
	rst update.
	rst moveFirst.
	[rst eof] whileFalse: [ 
		1 to: rst fields count do: [ :idx |
			Transcript show: (rst fields item: idx) name; show: ':'; 
			  			  show: (rst fields item: idx) value; cr].
		Transcript cr.
		rst moveNext	].
	
	rstNextVal close.
	rst close.
	conn close.
]

{ #category : #tests }
ADOClientTests >> testRstInsertSQLServer [
	| conn rst  |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;' 
		user: '' 
		password: ''.
	rst := ADORecordset createInstance .
	rst open: 'SELECT * FROM PERSON' activeConnection: conn cursorType: 2 lockType: 3 options: -1.

	rst addNew.
	(rst fields item: 2) value: 'John'.
	rst update.
	rst moveFirst.
	[rst eof] whileFalse: [ 
		1 to: rst fields count do: [ :idx |
			Transcript show: (rst fields item: idx) name; show: ':'; 
			  			  show: (rst fields item: idx) value; cr].
		Transcript cr.
		rst moveNext	].
	
	rst close.
	conn close.
]

{ #category : #tests }
ADOClientTests >> testSelect [
	| conn rst data |
	conn := ADOConnection createInstance.
	conn
		open:
			'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;AutoTranslate=true;'
		user: ''
		password: ''.
	rst := ADORecordset createInstance.
	rst
		open: 'SELECT * FROM [dbo].[myTable]'
		activeConnection: conn
		cursorType: 3
		lockType: 1
		options: -1.

	data := Array streamContents: [ :stream |
		[ rst eof ] whileFalse: [ 
			stream nextPut: ((1 to: rst fields count) collect: [ :idx | (rst fields item: idx) value ]).
			rst moveNext.
		 ].
	].
	data inspect.

	rst close.
	conn close
]
