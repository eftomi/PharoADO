Class {
	#name : #ADOClientTests,
	#superclass : #TestCase,
	#category : #'ADO-Tests'
}

{ #category : #tests }
ADOClientTests >> testConnectionAndRecordset [
	| conn rst fields data |
	conn := ADOConnection createInstance .
	conn 
		open: 'DSN=ISLOVAR;' 
		user: 'Islovar30' 
		password: 'informatika01'.
	rst := ADORecordset createInstance .
	rst 
		open: 'SELECT TOP 5 * FROM Term'
	 	activeConnection: conn 
		cursorType: 3 
		lockType:  1
		options: 0.
	fields := rst fields.
	data := Array streamContents: [ :outerOut |
		[ rst eof ] whileFalse: [ 
			outerOut nextPut: (
				Array streamContents: [ :innerOut |
					0 to: (fields count - 1) do: [ :idx | 
						innerOut nextPut: ((fields item: idx) value ).
						 ]
				 ]
			).
			rst moveNext.
		 ]
	].
	rst close.
	conn close.
]

{ #category : #tests }
ADOClientTests >> testDate [
	| conn rst data |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;;' 
		user: '' 
		password: ''.
	rst := conn execute: 'select birthDate from person'.
	data := (rst fields item: 0) value.
	rst close.
	conn close.

]

{ #category : #tests }
ADOClientTests >> testDecimal [
	| conn rst data |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;;' 
		user: '' 
		password: ''.
	rst := conn execute: 'insert into person (firstName, lastName) values (''Miha'', ''Krnek'')'.
	rst := conn execute: 'select @@identity'.
	data := (rst fields item: 0) value.
	rst close.
	conn close.
	self assert: data isNumber equals: true
]

{ #category : #tests }
ADOClientTests >> testDouble [
	| conn rst data |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;;' 
		user: '' 
		password: ''.
	rst := conn execute: 'select bmi from person'.
	data := (rst fields item: 0) value.
	rst close.
	conn close.
	self assert: data isFloat equals: true

]

{ #category : #tests }
ADOClientTests >> testInsert [
	| conn rst data |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;;' 
		user: '' 
		password: ''.
	conn execute: 'INSERT INTO Person (firstName,lastName,birthDate,bmi) VALUES (''John'',''Locke'',{ ts ''1760-08-29 00:00:00'' },20.59)'.
	conn close.
]

{ #category : #tests }
ADOClientTests >> testLocalDB [
	| conn rst fields data |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;' 
		user: '' 
		password: ''.
"	rst := ADORecordset createInstance .
	rst 
		open: 'SELECT TOP 5 * FROM Term'
	 	activeConnection: conn 
		cursorType: 3 
		lockType:  1
		options: 0.
	fields := rst fields.
	data := Array streamContents: [ :outerOut |
		[ rst eof ] whileFalse: [ 
			outerOut nextPut: (
				Array streamContents: [ :innerOut |
					0 to: (fields count - 1) do: [ :idx | 
						innerOut nextPut: ((fields item: idx) value ).
						 ]
				 ]
			).
			rst moveNext.
		 ]
	].
"
]

{ #category : #tests }
ADOClientTests >> testNull [
	| conn rst data |
	conn := ADOConnection createInstance .
	conn 
		open: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;;' 
		user: '' 
		password: ''.
	rst := conn execute: 'select @@identity'.
	data := (rst fields item: 0) value.
	rst close.
	conn close.
	self assert: data equals: nil
]
