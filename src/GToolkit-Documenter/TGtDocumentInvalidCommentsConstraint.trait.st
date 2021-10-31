Trait {
	#name : #TGtDocumentInvalidCommentsConstraint,
	#category : 'GToolkit-Documenter-Validation'
}

{ #category : #examples }
TGtDocumentInvalidCommentsConstraint >> issues [
	| parser results packages |
	parser := PRPillarParser new optimize.
	results := GtDocumentMissingReferencesGroup new.
	packages := self packagesToAnalyse.
	packages do: [ :aPackage | 
		(aPackage definedClasses select: #hasComment) do: [ :aClass |
			| visitor missingReferences |
			visitor := GtDocumentMissingReferencesVisitor new.
			missingReferences := visitor missingReferencesInClassCommentFor: aClass usingParser: parser.
			missingReferences isNotEmpty ifTrue: [ 
				results addMissingReferences: missingReferences ] ] ].
	^ results
]

{ #category : #accessing }
TGtDocumentInvalidCommentsConstraint >> packagesToAnalyse [
	self explicitRequirement
]
