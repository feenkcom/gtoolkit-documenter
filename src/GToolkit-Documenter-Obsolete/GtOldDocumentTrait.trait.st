Trait {
	#name : #GtOldDocumentTrait,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldDocumentTrait >> codeSnippets [
	<return: #GtCodeSnippets of: #GtDebuggableCodeSnippet>
	^ self explicitRequirement
]
