Class {
	#name : #ExampleObject,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'PharoADO-Glorp-Examples'
}

{ #category : #accessing }
ExampleObject >> id [
	^ id
]

{ #category : #accessing }
ExampleObject >> id: anObject [
	id := anObject
]
