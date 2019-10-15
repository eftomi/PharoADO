Class {
	#name : #BaselineOfPharoADO,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoADO
}

{ #category : #baselines }
BaselineOfPharoADO >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec baseline: 'PharoWin32' with: [ spec repository: 'github://tesonep/pharo-com:master/'].
			spec baseline: 'Glorp' with: [ spec repository: 'github://pharo-rdbms/glorp:master/'].
			spec baseline: 'P3' with: [ spec repository: 'github://svenvc/P3:master/'].

			spec package: 'PharoADO' with: [ spec requires: #('PharoWin32') ].
			spec package: 'PharoADO-Glorp' with: [ spec requires: #('PharoADO' 'Glorp' 'P3') ].

			spec group: 'default' with: #('PharoADO' 'PharoADO-Glorp') ].

]
