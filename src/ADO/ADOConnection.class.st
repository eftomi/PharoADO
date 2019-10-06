Class {
	#name : #ADOConnection,
	#superclass : #Object,
	#instVars : [
		'dispatchInstance'
	],
	#category : #ADO
}

{ #category : #'as yet unclassified' }
ADOConnection class >> createInstance [
	Ole32Lib uniqueInstance initLibrary.
	^self new 
		dispatchInstance: (COMDispatchInstance createInstanceByName: 'ADODB.Connection')
]

{ #category : #accessing }
ADOConnection >> dispatchInstance: anObject [
	dispatchInstance := anObject
]

{ #category : #testing }
ADOConnection >> isConnected [
	^ (dispatchInstance propertyNamed: 'State') = 1
]

{ #category : #'as yet unclassified' }
ADOConnection >> openWitchConnectString: aConnectString user: aUser password: aPassword [  
	dispatchInstance 
		dispatch: 'Open' 
		withArguments: { aConnectString . aUser . aPassword }
]
