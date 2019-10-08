Class {
	#name : #TestingDescriptorSystem,
	#superclass : #DescriptorSystem,
	#category : #'ADO-Glorp-Tests'
}

{ #category : #accessing }
TestingDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Person')
]

{ #category : #'as yet unclassified' }
TestingDescriptorSystem >> classModelForPerson: aClassModel [
	aClassModel newAttributeNamed: #id.
	aClassModel newAttributeNamed: #firstName.
	aClassModel newAttributeNamed: #lastName.
	aClassModel newAttributeNamed: #birthDate.
	aClassModel newAttributeNamed: #bmi.
]

{ #category : #'as yet unclassified' }
TestingDescriptorSystem >> descriptorForPerson: aDescriptor [
	| table |
	table := self tableNamed: 'PERSON'.
	aDescriptor table: table.
	aDescriptor directMappingFor: #id.
	(aDescriptor newMapping: DirectMapping)
		from: #firstName
		to: (table fieldNamed: 'firstName').
	(aDescriptor newMapping: DirectMapping)
		from: #lastName
		to: (table fieldNamed: 'lastName').
	(aDescriptor newMapping: DirectMapping)
		from: #birthDate
		to: (table fieldNamed: 'birthDate').
	(aDescriptor newMapping: DirectMapping)
		from: #bmi
		to: (table fieldNamed: 'bmi')
]

{ #category : #tables }
TestingDescriptorSystem >> tableForPERSON: aTable [
	(aTable createFieldNamed: 'id' type: platform serial)
		bePrimaryKey.
	aTable
		createFieldNamed: 'firstName'
		type: (platform varChar: 100).
	aTable
		createFieldNamed: 'lastName'
		type: (platform varChar: 100).
	aTable
		createFieldNamed: 'birthDate'
		type: platform date.
	aTable
		createFieldNamed: 'bmi'
		type: platform float.
]
