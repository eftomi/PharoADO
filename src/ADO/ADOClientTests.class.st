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
