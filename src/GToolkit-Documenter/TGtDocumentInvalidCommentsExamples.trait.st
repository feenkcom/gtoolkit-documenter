Trait {
	#name : #TGtDocumentInvalidCommentsExamples,
	#category : #'GToolkit-Documenter-Validation'
}

{ #category : #examples }
TGtDocumentInvalidCommentsExamples >> classCommentsWithMissingReferences [
	<gtExample>
	| results packages |
	results := GtDocumentMissingReferencesGroup new.
	packages := self packagesToAnalyse.
	packages do: [ :aPackage | 
		(aPackage definedClasses select: #hasComment) do: [ :aClass |
			| missingReferences |
			missingReferences := self missingReferencesForClass: aClass.
			missingReferences isNotEmpty ifTrue: [ 
				results addMissingReferences: missingReferences ] ] ].
	^ results
]

{ #category : #accessing }
TGtDocumentInvalidCommentsExamples >> missingReferencesForClass: aClass [
	| visitor missingReferences |
	visitor := GtDocumentMissingReferencesVisitor new.
	missingReferences := visitor missingReferencesInClassCommentFor: aClass.
	^ missingReferences
]

{ #category : #accessing }
TGtDocumentInvalidCommentsExamples >> packagesToAnalyse [
	self explicitRequirement
]
