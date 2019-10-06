Class {
	#name : #ADOConverter,
	#superclass : #Object,
	#instVars : [
		'encoder',
		'timezone',
		'map',
		'stringWriteStream',
		'asciiReadStream',
		'asciiWriteStream'
	],
	#category : #'ADO-Support'
}

{ #category : #accessing }
ADOConverter >> encoder [
	^ encoder ifNil: [ encoder := ZnCharacterEncoder utf8 ]
]

{ #category : #accessing }
ADOConverter >> encoder: anObject [
	encoder := anObject
]
