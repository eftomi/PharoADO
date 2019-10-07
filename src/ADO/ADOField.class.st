Class {
	#name : #ADOField,
	#superclass : #ADOObjects,
	#category : #'ADO-Core'
}

{ #category : #evaluating }
ADOField >> value [ 
	^dispatchInstance 
		propertyNamed: 'Value'
]
