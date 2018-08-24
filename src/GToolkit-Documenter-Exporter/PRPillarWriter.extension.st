Extension { #name : #PRPillarWriter }

{ #category : #'*GToolkit-Documenter-Exporter' }
PRPillarWriter >> visitGtPillarExampleCodeblock: aGtPillarExampleScript [ 
	aGtPillarExampleScript hasText ifTrue: [ ^ self visitCodeblock: aGtPillarExampleScript ].
	canvas raw: (self markupFor: aGtPillarExampleScript).
	self visitParametersOf: aGtPillarExampleScript.
	canvas raw: (self markupEndFor: aGtPillarExampleScript)
]
