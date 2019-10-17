Class {
	#name : #ADODatabaseDriver,
	#superclass : #DatabaseDriver,
	#instVars : [
		'rowCount'
	],
	#category : #'PharoADO-Glorp-Core'
}

{ #category : #executing }
ADODatabaseDriver >> basicExecuteSQLString: aString [
	| result |
	result := connection query: aString.
	
	rowCount := result size.
	^ ((rowCount > 0) ifTrue: [ result ] ifFalse: [ #() ]) readStream
]

{ #category : #transactions }
ADODatabaseDriver >> beginTransaction [
	connection connection beginTransaction 
]

{ #category : #transactions }
ADODatabaseDriver >> commitTransaction [
	connection connection commitTransaction 
]

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

{ #category : #transactions }
ADODatabaseDriver >> rollbackTransaction [
	connection connection rollbackTransaction 
]
