Extension { #name : #OmEntry }

{ #category : #'*GToolkit-NewDocumenter' }
OmEntry >> gtDefinitionFor: aView [
	<gtView>
	self content ifNil: [ ^ aView empty ].
	^ self content gtDefinitionFor: aView
]

{ #category : #'*GToolkit-NewDocumenter' }
OmEntry >> gtSystemFor: aView [
	<gtView>
	self content ifNil: [ ^ aView empty ].
	^ self content gtSystemFor: aView
]
