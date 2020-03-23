Class {
	#name : #ADOObjects,
	#superclass : #Object,
	#instVars : [
		'dispatchInstance'
	],
	#pools : [
		'ADOConstants'
	],
	#category : #'PharoADO-Core'
}

{ #category : #accessing }
ADOObjects >> dispatchInstance [
	^ dispatchInstance
]

{ #category : #accessing }
ADOObjects >> dispatchInstance: anObject [
	dispatchInstance := anObject
]
