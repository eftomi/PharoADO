Class {
	#name : #ADOField,
	#superclass : #ADOObjects,
	#category : #'PharoADO-Core'
}

{ #category : #accessing }
ADOField >> name [ 
	^dispatchInstance 
		propertyNamed: 'Name'
]

{ #category : #accessing }
ADOField >> name: aString [ 
	^dispatchInstance 
		propertyNamed: 'Name'
		put: aString
]

{ #category : #evaluating }
ADOField >> value [ 
	^dispatchInstance 
		propertyNamed: 'Value'
]

{ #category : #accessing }
ADOField >> value: aValue [ 
	^dispatchInstance 
		propertyNamed: 'Value'
		put: aValue
]
