Class {
	#name : #ADOConnection,
	#superclass : #ADOObjects,
	#category : #'PharoADO-Core'
}

{ #category : #'as yet unclassified' }
ADOConnection class >> createInstance [
	Ole32Lib uniqueInstance initLibrary.
	^self new 
		dispatchInstance: (COMDispatchInstance createInstanceByName: 'ADODB.Connection')
]

{ #category : #transactions }
ADOConnection >> beginTransaction [
	dispatchInstance 
		dispatch: 'BeginTrans' 

]

{ #category : #'initialize-release' }
ADOConnection >> close [
	dispatchInstance
		dispatch: 'Close'
]

{ #category : #transactions }
ADOConnection >> commitTransaction [
	dispatchInstance 
		dispatch: 'CommitTrans' 

]

{ #category : #running }
ADOConnection >> execute: aString [ 
	| rst |
	rst := ADORecordset new.
	rst dispatchInstance: (
		dispatchInstance 
			dispatch: 'Execute' 
			withArguments: { aString }).
	^rst
]

{ #category : #testing }
ADOConnection >> isConnected [
	^ (dispatchInstance propertyNamed: 'State') = 1
]

{ #category : #'as yet unclassified' }
ADOConnection >> open: aConnectString user: aUser password: aPassword [  
	dispatchInstance 
		dispatch: 'Open' 
		withArguments: { aConnectString . aUser . aPassword }
]

{ #category : #transactions }
ADOConnection >> rollbackTransaction [
	dispatchInstance 
		dispatch: 'RollbackTrans' 

]
