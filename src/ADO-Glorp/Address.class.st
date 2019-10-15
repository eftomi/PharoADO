Class {
	#name : #Address,
	#superclass : #ExampleObject,
	#instVars : [
		'street',
		'number',
		'city',
		'zip'
	],
	#category : #'ADO-Glorp-Examples'
}

{ #category : #accessing }
Address >> city [
	^ city
]

{ #category : #accessing }
Address >> city: anObject [
	city := anObject
]

{ #category : #accessing }
Address >> number [
	^ number
]

{ #category : #accessing }
Address >> number: anObject [
	number := anObject
]

{ #category : #accessing }
Address >> street [
	^ street
]

{ #category : #accessing }
Address >> street: anObject [
	street := anObject
]

{ #category : #accessing }
Address >> zip [
	^ zip
]

{ #category : #accessing }
Address >> zip: anObject [
	zip := anObject
]
