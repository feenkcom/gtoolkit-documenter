Trait {
	#name : 'TGt2DocumentConstants',
	#category : 'GToolkit-Documenter-Utility'
}

{ #category : 'accessing' }
TGt2DocumentConstants classSide >> constants [
	^ GtDocumentConstants
]

{ #category : 'testing' }
TGt2DocumentConstants classSide >> isDeprecated [
	^ self name = #TGt2DocumentConstants
]

{ #category : 'accessing' }
TGt2DocumentConstants >> constants [
	^ GtDocumentConstants
]
