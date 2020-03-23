Class {
	#name : #ADORecordset,
	#superclass : #ADOObjects,
	#instVars : [
		'fields'
	],
	#category : #'PharoADO-Core'
}

{ #category : #'instance creation' }
ADORecordset class >> createInstance [
	Ole32Lib uniqueInstance initLibrary.
	^self new 
		dispatchInstance: (COMDispatchInstance createInstanceByName: 'ADODB.Recordset')
]

{ #category : #adding }
ADORecordset >> addNew [
	dispatchInstance
		dispatch: 'AddNew'

]

{ #category : #converting }
ADORecordset >> asOrderedDictionary [
	^OrderedDictionary
		withAll:
			((1 to: self fields count)
				collect: [ :index | 
					| item |
					item := self fields item: index.
					item name -> item value ])
]

{ #category : #testing }
ADORecordset >> atEnd [
	^self eof
]

{ #category : #'as yet unclassified' }
ADORecordset >> bof [
	^dispatchInstance
		propertyNamed: 'BOF'
]

{ #category : #actions }
ADORecordset >> cancel [
	dispatchInstance
		dispatch: 'Cancel'
]

{ #category : #'as yet unclassified' }
ADORecordset >> cancelUpdate [
	dispatchInstance
		dispatch: 'CancelUpdate'
]

{ #category : #'initialize-release' }
ADORecordset >> close [
	self resetFields.
	dispatchInstance dispatch: 'Close'
]

{ #category : #'submorphs-add/remove' }
ADORecordset >> delete [ 
	dispatchInstance
		dispatch: 'Delete'
]

{ #category : #'as yet unclassified' }
ADORecordset >> eof [
	^dispatchInstance
		propertyNamed: 'EOF'
]

{ #category : #accessing }
ADORecordset >> fields [ 

	fields ifNil: [fields := ADOFields new.
	fields dispatchInstance: 
		(dispatchInstance propertyNamed: 'Fields')].
	^fields
]

{ #category : #'as yet unclassified' }
ADORecordset >> moveFirst [
	dispatchInstance
		dispatch: 'MoveFirst'
]

{ #category : #'as yet unclassified' }
ADORecordset >> moveLast [
	dispatchInstance
		dispatch: 'MoveLast'
]

{ #category : #'as yet unclassified' }
ADORecordset >> moveNext [
	dispatchInstance
		dispatch: 'MoveNext'
]

{ #category : #'as yet unclassified' }
ADORecordset >> movePrevious [
	dispatchInstance
		dispatch: 'MovePrevious'
]

{ #category : #'as yet unclassified' }
ADORecordset >> open: aString activeConnection: aConnection cursorType: aCursorType lockType: aLockType options: anOptions [
	self resetFields.
	dispatchInstance
		dispatch: 'Open'
		withArguments:
			{aString.
			aConnection dispatchInstance.
			aCursorType.
			aLockType.
			anOptions}
]

{ #category : #'as yet unclassified' }
ADORecordset >> recordCount [
	^dispatchInstance
		propertyNamed: 'RecordCount'
]

{ #category : #'as yet unclassified' }
ADORecordset >> requery [
	dispatchInstance
		dispatch: 'Requery'
]

{ #category : #'initialize-release' }
ADORecordset >> resetFields [
	fields := nil
]

{ #category : #'accessing structure variables' }
ADORecordset >> state [
	^dispatchInstance
		propertyNamed: 'State'
]

{ #category : #updating }
ADORecordset >> update [
	dispatchInstance
		dispatch: 'Update'
]
