Class {
	#name : #OraclePlatformADO,
	#superclass : #OraclePlatform,
	#category : #'PharoADO-Glorp-Platforms'
}

{ #category : #types }
OraclePlatformADO >> decimal [
	^self typeNamed: #decimal ifAbsentPut: [GlorpDecimalType new typeString: 'decimal'].
]
