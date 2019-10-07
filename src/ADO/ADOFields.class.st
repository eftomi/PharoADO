Class {
	#name : #ADOFields,
	#superclass : #ADOObjects,
	#category : #'ADO-Core'
}

{ #category : #accessing }
ADOFields >> count [ 
	^dispatchInstance 
		propertyNamed: 'Count'
]

{ #category : #accessing }
ADOFields >> item: anInteger [
	| field |
	field := ADOField new.
	field dispatchInstance: 
		(dispatchInstance
			propertyNamed: 'Item'
			withArguments: { anInteger }).
	^field
		
]
