Class {
	#name : #ADOClient,
	#superclass : #Object,
	#instVars : [
		'connection',
		'session',
		'settings',
		'properties'
	],
	#category : #'ADO-Core'
}

{ #category : #private }
ADOClient >> clearSession [
	session := nil
]

{ #category : #'initialize-release' }
ADOClient >> close [
	"Cleanly close my connection with the server"
	connection
		ifNotNil: [ 
			[ connection dispatch: 'Close' ] on: Error do: [  ].
				self clearSession.
			connection := nil ]
]

{ #category : #public }
ADOClient >> connect [
	self ensureOpen.
	session := 999999 atRandom. 
	
]

{ #category : #accessing }
ADOClient >> connectString [
	"Return the password  of my database connection.
	For no password, nil is used."

	^ settings at: #connectString ifAbsent: [ nil ]
]

{ #category : #accessing }
ADOClient >> connectString: aString [
	"Set the password to use when connecting.
	Set to nil or don't set to use no password."

	settings at: #connectString put: aString

]

{ #category : #accessing }
ADOClient >> connection [
	^ connection
]

{ #category : #accessing }
ADOClient >> database [
	"Return the database name I (want to) connect to.
	For the default, nil is used."
	
	^ settings at: #database ifAbsent: [ nil ]
]

{ #category : #'initialize-release' }
ADOClient >> database: string [
	"Set the name of the database to connect to.
	Set to nil or do not set to use the default."
	
	settings at: #database put: string
]

{ #category : #private }
ADOClient >> ensureConnected [
	self isConnected
		ifFalse: [ self connect ] 
]

{ #category : #private }
ADOClient >> ensureOpen [
	connection ifNil: [ self open ]
]

{ #category : #initialization }
ADOClient >> initialize [
	super initialize.
	
	settings := IdentityDictionary new.
	properties := Dictionary new.
]

{ #category : #testing }
ADOClient >> isConnected [
	"Return true when my connection is in working order (from my end)"

	^ connection notNil and: [ 
			(connection isConnected) and: [ 
				session notNil 
			] 
		]
]

{ #category : #'instance creation' }
ADOClient >> open [
	"Open my connection with the server (do not yet #connect)"
	
	self close.
	
	connection := ADOConnection createInstance .
	connection open: self connectString user: self user password: self password.
	
]

{ #category : #accessing }
ADOClient >> password [
	"Return the password  of my database connection.
	For no password, nil is used."

	^ settings at: #password ifAbsent: [ nil ]
]

{ #category : #accessing }
ADOClient >> password: string [
	"Set the password to use when connecting.
	Set to nil or don't set to use no password."

	settings at: #password put: string
]

{ #category : #accessing }
ADOClient >> query: aString [
	| rst fields data |
	self ensureConnected.
	rst := connection execute: aString.

	rst ifNil: [ ^ #() ].
	rst state = 0
		ifTrue: [ ^ #() ].
	(rst eof and: [ rst bof ])
		ifTrue: [ ^ #() ].

	fields := rst fields.
	data := Array
		streamContents: [ :outerOut | 
			[ rst eof ]
				whileFalse: [ outerOut
						nextPut:
							(Array
								streamContents: [ :innerOut | 
									0 to: fields count - 1 do:
										[ :idx | innerOut nextPut: (fields item: idx) value ] ]).
					rst moveNext ] ].
	^ data


	"	rst := ADORecordset createInstance.
	rst 
		open: aString 
		activeConnection: connection
		cursorType: 3 
		lockType: 1 
		options: 0.
"
]

{ #category : #accessing }
ADOClient >> queryEncoding [
	"Return the name of the encoder used"
	
	^ self converter encoder identifier
]

{ #category : #accessing }
ADOClient >> user [
	"Return the user of my database connection.
	For the default, nil is used."

	^ settings at: #user ifAbsent: [ nil ]
]

{ #category : #accessing }
ADOClient >> user: string [
	"Set the user to use when connecting.
	Set to nil or don't set to use the default."
	
	settings at: #user put: string
]
