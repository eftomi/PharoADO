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

{ #category : #actions }
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

{ #category : #testing }
ADORecordset >> bof [
	^dispatchInstance
		propertyNamed: 'BOF'
]

{ #category : #actions }
ADORecordset >> cancel [
	dispatchInstance
		dispatch: 'Cancel'
]

{ #category : #actions }
ADORecordset >> cancelUpdate [
	dispatchInstance
		dispatch: 'CancelUpdate'
]

{ #category : #actions }
ADORecordset >> close [
	self resetFields.
	dispatchInstance dispatch: 'Close'
]

{ #category : #actions }
ADORecordset >> delete [ 
	dispatchInstance
		dispatch: 'Delete'
]

{ #category : #testing }
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

{ #category : #positioning }
ADORecordset >> moveFirst [
	dispatchInstance
		dispatch: 'MoveFirst'
]

{ #category : #positioning }
ADORecordset >> moveLast [
	dispatchInstance
		dispatch: 'MoveLast'
]

{ #category : #positioning }
ADORecordset >> moveNext [
	dispatchInstance
		dispatch: 'MoveNext'
]

{ #category : #positioning }
ADORecordset >> movePrevious [
	dispatchInstance
		dispatch: 'MovePrevious'
]

{ #category : #querying }
ADORecordset >> open: aString activeConnection: anADOConnection [
	^ self
		open: aString
		activeConnection: anADOConnection
		cursorType: ADOpenForwardOnly
		lockType: ADLockReadOnly
		options: ADCmdUnspecified
]

{ #category : #querying }
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

{ #category : #accessing }
ADORecordset >> recordCount [
	^dispatchInstance
		propertyNamed: 'RecordCount'
]

{ #category : #actions }
ADORecordset >> requery [
	dispatchInstance
		dispatch: 'Requery'
]

{ #category : #'initialize-release' }
ADORecordset >> resetFields [
	fields := nil
]

{ #category : #accessing }
ADORecordset >> state [
	^dispatchInstance
		propertyNamed: 'State'
]

{ #category : #actions }
ADORecordset >> update [
	dispatchInstance
		dispatch: 'Update'
]

{ #category : #'accessing-values' }
ADORecordset >> valueAt: fieldName [ 
	^self fields valueAt: fieldName
]
