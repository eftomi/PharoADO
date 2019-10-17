Class {
	#name : #InvoiceItem,
	#superclass : #ExampleObject,
	#instVars : [
		'invoice',
		'description',
		'price'
	],
	#category : #'PharoADO-Glorp-Examples'
}

{ #category : #'as yet unclassified' }
InvoiceItem class >> description: aString price: aNumber [
	^ self new
		description: aString;
		price: aNumber;
		yourself
]

{ #category : #accessing }
InvoiceItem >> description [
	^ description
]

{ #category : #accessing }
InvoiceItem >> description: anObject [
	description := anObject
]

{ #category : #accessing }
InvoiceItem >> invoice [
	^ invoice
]

{ #category : #accessing }
InvoiceItem >> invoice: anObject [
	invoice := anObject
]

{ #category : #accessing }
InvoiceItem >> price [
	^ price
]

{ #category : #accessing }
InvoiceItem >> price: anObject [
	price := anObject
]
