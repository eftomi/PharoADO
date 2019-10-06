Class {
	#name : #ADODatabaseDriver,
	#superclass : #DatabaseDriver,
	#instVars : [
		'rowCount'
	],
	#category : #'ADO-Glorp'
}

{ #category : #accessing }
ADODatabaseDriver >> connect: aLogin [
	connection := self connectionClass new.
	connection 
		connectString: aLogin connectString;
		user: aLogin username;
		password: aLogin password.
	connection connect
]

{ #category : #accessing }
ADODatabaseDriver >> connectionClass [
	^ADOClient 
]

{ #category : #testing }
ADODatabaseDriver >> isConnected [
	^ connection notNil and: [ connection isConnected ]
]
