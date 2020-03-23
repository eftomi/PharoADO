Class {
	#name : #ADOConstants,
	#superclass : #SharedPool,
	#classVars : [
		'ADCmdUnspecified',
		'ADLockBatchOptimistic',
		'ADLockOptimistic',
		'ADLockPessimistic',
		'ADLockReadOnly',
		'ADLockUnspecified',
		'ADOpenDynamic',
		'ADOpenForwardOnly',
		'ADOpenKeyset',
		'ADOpenStatic',
		'ADOpenUnspecified'
	],
	#category : #'PharoADO-Core'
}

{ #category : #'class initialization' }
ADOConstants class >> initialize [
	self
		initializeLockConstants;
		initializeOpenConstants.
		
	ADCmdUnspecified := -1
]

{ #category : #'class initialization' }
ADOConstants class >> initializeLockConstants [
	ADLockUnspecified := -1.
	ADLockReadOnly := 1.
	ADLockPessimistic := 2.
	ADLockOptimistic := 3.
	ADLockBatchOptimistic := 4.
]

{ #category : #'class initialization' }
ADOConstants class >> initializeOpenConstants [
	ADOpenDynamic := 2.
	ADOpenForwardOnly := 0.
	ADOpenKeyset := 1.
	ADOpenStatic := 3.
	ADOpenUnspecified := -1
]
