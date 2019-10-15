Class {
	#name : #ADOFields,
	#superclass : #ADOObjects,
	#category : #'PharoADO-Core'
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
			withArguments: { anInteger - 1 }).
	^field
		
]
