Class {
	#name : #Person,
	#superclass : #Object,
	#instVars : [
		'id',
		'firstName',
		'lastName',
		'birthDate'
	],
	#category : #'ADO-Glorp-Tests'
}

{ #category : #accessing }
Person >> birthDate [
	^ birthDate
]

{ #category : #accessing }
Person >> birthDate: aDate [
	birthDate := aDate
]

{ #category : #accessing }
Person >> firstName [
	^ firstName
]

{ #category : #accessing }
Person >> firstName: aString [
	firstName := aString
]

{ #category : #initialization }
Person >> initialize [
	super initialize.
	birthDate := '1/1/1970' asDate
]

{ #category : #accessing }
Person >> lastName [
	^ lastName
]

{ #category : #accessing }
Person >> lastName: aString [
	lastName := aString
]
