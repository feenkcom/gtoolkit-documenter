Extension { #name : #OmEntry }

{ #category : #'*GToolkit-Documenter' }
OmEntry >> gtDefinitionFor: aView [
	<gtView>
	self content ifNil: [ ^ aView empty ].
	^ self content gtDefinitionFor: aView
]

{ #category : #'*GToolkit-Documenter' }
OmEntry >> gtSystemFor: aView [
	<gtView>
	self content ifNil: [ ^ aView empty ].
	^ self content gtSystemFor: aView
]
