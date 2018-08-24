Extension { #name : #EpLog }

{ #category : #'*GToolkit-Documenter-Epicea' }
EpLog >> gtInspectorEntriesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ self store ifNotNil: [ :aStore |
		(aStore gtInspectorEntriesIn: composite) ]
]
