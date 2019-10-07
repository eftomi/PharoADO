Class {
	#name : #ADORecordset,
	#superclass : #ADOObjects,
	#category : #'ADO-Core'
}

{ #category : #'as yet unclassified' }
ADORecordset class >> createInstance [
	Ole32Lib uniqueInstance initLibrary.
	^self new 
		dispatchInstance: (COMDispatchInstance createInstanceByName: 'ADODB.Recordset')
]

{ #category : #'as yet unclassified' }
ADORecordset >> bof [
	^dispatchInstance
		propertyNamed: 'BOF'
]

{ #category : #'initialize-release' }
ADORecordset >> close [
	dispatchInstance
		dispatch: 'Close'
]

{ #category : #'as yet unclassified' }
ADORecordset >> eof [
	^dispatchInstance
		propertyNamed: 'EOF'
]

{ #category : #accessing }
ADORecordset >> fields [ 
	| fields |
	fields := ADOFields new.
	fields dispatchInstance: 
		(dispatchInstance propertyNamed: 'Fields').
	^fields
]

{ #category : #'as yet unclassified' }
ADORecordset >> moveNext [
	dispatchInstance
		dispatch: 'MoveNext'
]

{ #category : #'as yet unclassified' }
ADORecordset >> open: aString activeConnection: aConnection cursorType: aCursorType lockType: aLockType options: anOptions [
	dispatchInstance 
		dispatch: 'Open'
		withArguments: { 
			aString.
			aConnection dispatchInstance.
			aCursorType .
			aLockType.
			anOptions.
		 }
]

{ #category : #'accessing structure variables' }
ADORecordset >> state [
	^dispatchInstance
		propertyNamed: 'State'
]
