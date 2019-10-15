Class {
	#name : #ExampleDescriptorSystem,
	#superclass : #DescriptorSystem,
	#category : #'PharoADO-Glorp-Examples'
}

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> classModelForAddress: aClassModel [
	(aClassModel newAttributeNamed: #id) useDirectAccess: true.
	aClassModel newAttributeNamed: #street.
	aClassModel newAttributeNamed: #zip
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> classModelForInvoice: aClassModel [
	(aClassModel newAttributeNamed: #id) useDirectAccess: true.
	aClassModel newAttributeNamed: #issueDate.
	aClassModel newAttributeNamed: #person type: Person.
	aClassModel newAttributeNamed: #address type: Address.
	aClassModel newAttributeNamed: #items collectionOf: InvoiceItem
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> classModelForInvoiceItem: aClassModel [
	(aClassModel newAttributeNamed: #id) useDirectAccess: true.
	aClassModel newAttributeNamed: #invoice type: Invoice.
	aClassModel newAttributeNamed: #description.
	aClassModel newAttributeNamed: #price
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> classModelForPerson: aClassModel [
	(aClassModel newAttributeNamed: #id) useDirectAccess: true.
	aClassModel newAttributeNamed: #firstName.
	aClassModel newAttributeNamed: #lastName.
	aClassModel newAttributeNamed: #email.
	aClassModel newAttributeNamed: #birthDate.
	aClassModel newAttributeNamed: #addresses collectionOf: Address.
	aClassModel newAttributeNamed: #invoices collectionOf: Invoice.

]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> descriptorForAddress: aDescriptor [
	| table |
	table := self tableNamed: 'ADDRESS'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (table fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #street
		to: (table fieldNamed: 'street').
	(aDescriptor newMapping: DirectMapping)
		from: #city
		to: (table fieldNamed: 'zip').
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> descriptorForInvoice: aDescriptor [
	| table |
	table := self tableNamed: 'INVOICE'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (table fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #issueDate
		to: (table fieldNamed: 'issueDate').
	(aDescriptor newMapping: OneToOneMapping)
		attributeName: #person.
	(aDescriptor newMapping: OneToOneMapping)
		attributeName: #address.
	(aDescriptor newMapping: ToManyMapping)
		attributeName: #items;
		orderBy: [:each |
	(each getTable: 'INVOICEITEM') getField: 'position'];
		writeTheOrderField.
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> descriptorForInvoiceItem: aDescriptor [
	| table |
	table := self tableNamed: 'INVOICEITEM'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (table fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #description
		to: (table fieldNamed: 'description').
	(aDescriptor newMapping: DirectMapping)
		from: #price
		to: (table fieldNamed: 'price').
	(aDescriptor newMapping: OneToOneMapping)
		attributeName: #invoice.
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> descriptorForPerson: aDescriptor [
	| table linkTable |
	table := self tableNamed: 'PERSON'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #id
		to: (table fieldNamed: 'id').
	(aDescriptor newMapping: DirectMapping)
		from: #firstName
		to: (table fieldNamed: 'firstName').
	(aDescriptor newMapping: DirectMapping)
		from: #lastName
		to: (table fieldNamed: 'lastName').
	(aDescriptor newMapping: DirectMapping)
		from: #email
		to: (table fieldNamed: 'email').
	(aDescriptor newMapping: DirectMapping)
		from: #birthDate
		to: (table fieldNamed: 'birthDate').
		
	(aDescriptor newMapping: ToManyMapping)
		attributeName: #invoices;
		orderBy: [:each |
	(each getTable: 'INVOICE') getField: 'issueDate'].

	linkTable := self tableNamed: 'PERSON_ON_ADDRESS'.
	(aDescriptor newMapping: ManyToManyMapping)
		attributeName: #addresses;
		referenceClass: Address;
		beExclusive;
		join: (Join
			from: (table fieldNamed: 'id')
			to: (linkTable fieldNamed: 'person_id')).

]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> tableForADDRESS: aTable [
	(aTable createFieldNamed: 'id' type: platform serial) bePrimaryKey.
	aTable createFieldNamed: 'street' type: (platform varChar: 100).
	aTable createFieldNamed: 'zip' type: platform integer.
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> tableForINVOICE: aTable [
| personField addressField |
	(aTable createFieldNamed: 'id' type: platform serial)
		bePrimaryKey.
	aTable createFieldNamed: 'issueDate' type: platform date.
	personField := aTable
		createFieldNamed: 'person_id'
		type: platform integer.
	addressField := aTable
		createFieldNamed: 'address_id'
		type: platform integer.
	aTable
		addForeignKeyFrom: personField
		to: ((self tableNamed: 'PERSON') fieldNamed: 'id').
	aTable
		addForeignKeyFrom: addressField
		to: ((self tableNamed: 'ADDRESS') fieldNamed: 'id').
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> tableForINVOICEITEM: aTable [
	| invoiceField |
	(aTable createFieldNamed: 'id' type: platform serial) bePrimaryKey.
	invoiceField := aTable createFieldNamed: 'invoice_id' type:
		platform integer.
	aTable createFieldNamed: 'description' type: (platform varchar: 150).
	aTable createFieldNamed: 'price' type: (platform decimal precision: 10; scale: 2).
	aTable createFieldNamed: 'position' type: platform integer.
	aTable
		addForeignKeyFrom: invoiceField
		to: ((self tableNamed: 'INVOICE') fieldNamed: 'id').
]

{ #category : #tables }
ExampleDescriptorSystem >> tableForPERSON: aTable [
	(aTable createFieldNamed: 'id' type: platform serial) bePrimaryKey.
	aTable createFieldNamed: 'firstName' type: (platform varChar: 100).
	aTable createFieldNamed: 'lastName' type: (platform varChar: 100).
	aTable createFieldNamed: 'email' type: (platform varchar: 200).
	aTable createFieldNamed: 'birthDate' type: platform date.
]

{ #category : #'as yet unclassified' }
ExampleDescriptorSystem >> tableForPERSON_ON_ADDRESS: aTable [
	| personField addressField |
	personField := aTable
		createFieldNamed: 'person_id'
		type: platform integer.
	addressField := aTable
		createFieldNamed: 'address_id'
		type: platform integer.
	personField bePrimaryKey.
	addressField bePrimaryKey.
	aTable
		addForeignKeyFrom: personField
		to: ((self tableNamed: 'PERSON') fieldNamed: 'id').
	aTable
		addForeignKeyFrom: addressField
	to: ((self tableNamed: 'ADDRESS') fieldNamed: 'id').
]
