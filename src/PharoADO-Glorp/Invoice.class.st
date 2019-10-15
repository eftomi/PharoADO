Class {
	#name : #Invoice,
	#superclass : #ExampleObject,
	#instVars : [
		'issueDate',
		'person',
		'address',
		'items'
	],
	#category : #'PharoADO-Glorp-Examples'
}

{ #category : #adding }
Invoice >> addItem: anInvoiceItem [
	anInvoiceItem invoice: self.
	self items add: anInvoiceItem
]

{ #category : #accessing }
Invoice >> address [
	^ address
]

{ #category : #accessing }
Invoice >> address: anObject [
	address := anObject
]

{ #category : #initialization }
Invoice >> initialize [
	super initialize.
	items := OrderedCollection new.
]

{ #category : #accessing }
Invoice >> issueDate [
	^ issueDate
]

{ #category : #accessing }
Invoice >> issueDate: anObject [
	issueDate := anObject
]

{ #category : #accessing }
Invoice >> items [
	^ items
]

{ #category : #accessing }
Invoice >> items: anObject [
	items := anObject
]

{ #category : #accessing }
Invoice >> person [
	^ person
]

{ #category : #accessing }
Invoice >> person: anObject [
	person := anObject
]

{ #category : #accessing }
Invoice >> totalPrice [
	^ self items sum: #price
]
