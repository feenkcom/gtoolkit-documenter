Extension { #name : #EpLog }

{ #category : #'*GToolkit-Documenter-Epicea' }
EpLog >> gtEntriesFor: aView [
	<gtView>
	^ self store 
		ifNotNil: [ :aStore |
			(aStore gtEntriesFor: aView) ]
		ifNil: [ aView empty ]
]

{ #category : #'*GToolkit-Documenter-Epicea' }
EpLog >> gtInspectorEntriesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ self store ifNotNil: [ :aStore |
		(aStore gtInspectorEntriesIn: composite) ]
]
