Class {
	#name : #Person,
	#superclass : #ExampleObject,
	#instVars : [
		'firstName',
		'email',
		'lastName',
		'birthDate',
		'addresses',
		'invoices',
		'tags'
	],
	#category : #'ADO-Glorp-Examples'
}

{ #category : #accessing }
Person >> addresses [
	^ addresses
]

{ #category : #accessing }
Person >> addresses: anObject [
	addresses := anObject
]

{ #category : #accessing }
Person >> birthDate [
	^ birthDate
]

{ #category : #accessing }
Person >> birthDate: anObject [
	birthDate := anObject
]

{ #category : #accessing }
Person >> email [
	^ email
]

{ #category : #accessing }
Person >> email: anObject [
	email := anObject
]

{ #category : #accessing }
Person >> firstName [
	^ firstName
]

{ #category : #accessing }
Person >> firstName: anObject [
	firstName := anObject
]

{ #category : #initialization }
Person >> initialize [
	super initialize.
	addresses := OrderedCollection new.
	invoices := OrderedCollection new.
]

{ #category : #accessing }
Person >> invoices [
	^ invoices
]

{ #category : #accessing }
Person >> invoices: anObject [
	invoices := anObject
]

{ #category : #accessing }
Person >> lastName [
	^ lastName
]

{ #category : #accessing }
Person >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
Person >> tags [
	^ tags
]

{ #category : #accessing }
Person >> tags: anObject [
	tags := anObject
]
