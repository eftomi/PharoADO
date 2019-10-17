Class {
	#name : #ADOObjects,
	#superclass : #Object,
	#instVars : [
		'dispatchInstance'
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
