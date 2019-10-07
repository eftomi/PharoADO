Class {
	#name : #ADOObjects,
	#superclass : #Object,
	#instVars : [
		'dispatchInstance'
	],
	#category : #'ADO-Core'
}

{ #category : #accessing }
ADOObjects >> dispatchInstance [
	^ dispatchInstance
]

{ #category : #accessing }
ADOObjects >> dispatchInstance: anObject [
	dispatchInstance := anObject
]
