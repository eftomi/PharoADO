Extension { #name : #WideString }

{ #category : #'*PharoADO-Glorp' }
WideString >> glorpPrintSQLOn: aCommand [
	| platform requiresEscape |
	platform := [aCommand platform] on: MessageNotUnderstood do: [:ex | ex return: nil].
	(platform respondsTo: #prefixForUnicode) ifTrue: [ aCommand nextPut: platform prefixForUnicode ].
	aCommand nextPut: $'.
	1
		to: self size
		do:
			[:i | 
			| char |
			char := self at: i.
			requiresEscape := platform isNil ifTrue: [false] ifFalse: [platform requiresEscapeFor: char].
			requiresEscape
				ifTrue: [aCommand nextPutAll: (aCommand platform escapeFor: char)]
				ifFalse: [aCommand nextPut: char]].
	aCommand nextPut: $'.
]
