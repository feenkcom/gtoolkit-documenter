Trait {
	#name : #GtPillarNodeWithDocumentTrait,
	#category : 'GToolkit-Documenter-Pillar - Nodes'
}

{ #category : #accessing }
GtPillarNodeWithDocumentTrait >> document [
	<return: #GtDocument>
	^ self propertyAt: #document
]

{ #category : #accessing }
GtPillarNodeWithDocumentTrait >> document: aGtDocument [
	self 
		assert: [ aGtDocument notNil ]
		description: [ 'Pillar node''s document must be non-nil' ].
	^ self propertyAt: #document put: aGtDocument
]
