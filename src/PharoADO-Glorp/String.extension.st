Extension { #name : #String }

{ #category : #'*PharoADO-Glorp' }
String >> regexMatches: anObject [
	^self allRegexMatches: anObject 
]
