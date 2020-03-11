Class {
	#name : #ADOFields,
	#superclass : #ADOObjects,
	#instVars : [
		'items'
	],
	#category : #'PharoADO-Core'
}

{ #category : #accessing }
ADOFields >> count [ 
	^dispatchInstance 
		propertyNamed: 'Count'
]

{ #category : #accessing }
ADOFields >> item: anInteger [
	^ (self items
		at: anInteger
		ifAbsent: [ nil ])
			ifNil:  
		 [ | field |
			field := ADOField new.
			field
				dispatchInstance:
					(dispatchInstance
						propertyNamed: 'Item'
						withArguments: {(anInteger - 1)}).
			self items at: anInteger put: field ]
]

{ #category : #accessing }
ADOFields >> items [

	^items ifNil: [ items := Array new: self count ]

]
