Class {
	#name : #ADOFields,
	#superclass : #ADOObjects,
	#instVars : [
		'items',
		'fieldsMap'
	],
	#category : #'PharoADO-Core'
}

{ #category : #accessing }
ADOFields >> count [ 
	^dispatchInstance 
		propertyNamed: 'Count'
]

{ #category : #'private-accessing' }
ADOFields >> fieldsMap [
	fieldsMap
		ifNil: [ fieldsMap := OrderedDictionary
				withAll: (self items collect: [ :field | field name -> field ]) ].
	^ fieldsMap
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

{ #category : #'accessing-values' }
ADOFields >> valueAt: aString [ 
	
	^(self fieldsMap at: aString) value
]
