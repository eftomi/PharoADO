Class {
	#name : #ExampleObject,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'ADO-Glorp-Examples'
}

{ #category : #accessing }
ExampleObject >> id [
	^ id
]

{ #category : #accessing }
ExampleObject >> id: anObject [
	id := anObject
]
