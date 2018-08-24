Extension { #name : #PRVisitor }

{ #category : #'*GToolkit-Documenter-Exporter' }
PRVisitor >> visitCodePartOfGtPillarExampleScript: aGtPillarExampleScript [
	self visitCodeblock: aGtPillarExampleScript
]

{ #category : #'*GToolkit-Documenter-Exporter' }
PRVisitor >> visitGtPillarEpiceaCodeblock: aGtPillarEpiceaCodeblock [ 
	self visitCodeblock: aGtPillarEpiceaCodeblock
]

{ #category : #'*GToolkit-Documenter-Exporter' }
PRVisitor >> visitGtPillarExampleCodeblock: aGtPillarExampleScript [
	| figure fileName |
	aGtPillarExampleScript shouldDisplaySourceCode
		ifTrue: [ self visitCodePartOfGtPillarExampleScript: aGtPillarExampleScript ].
	aGtPillarExampleScript example ifNil: [ ^ nil ].
	aGtPillarExampleScript show ifNil: [ ^ nil ].
	figure := PRFigure new.
	figure label: 'figure-' , aGtPillarExampleScript example.
	figure
		add: (PRText content: 'Result of ' , aGtPillarExampleScript example).
	fileName := GtFileUtility 
		secureFileName: aGtPillarExampleScript example asLowercase 
		extension: 'svg'.
	figure reference: 'file://gt-figures/' , fileName.
	self visitFigure: figure.
	^ fileName
]
