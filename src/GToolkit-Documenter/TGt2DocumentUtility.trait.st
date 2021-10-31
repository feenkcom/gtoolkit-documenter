Trait {
	#name : #TGt2DocumentUtility,
	#category : 'GToolkit-Documenter-Utility'
}

{ #category : #testing }
TGt2DocumentUtility classSide >> isDeprecated [
	^ self name = #TGt2DocumentUtility 
]

{ #category : #private }
TGt2DocumentUtility classSide >> utility [
	^ GtDocumentUtility
]

{ #category : #private }
TGt2DocumentUtility >> utility [
	^ GtDocumentUtility
]
