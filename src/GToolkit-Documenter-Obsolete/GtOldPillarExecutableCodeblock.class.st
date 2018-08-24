Class {
	#name : #GtOldPillarExecutableCodeblock,
	#superclass : #GtOldPillarCodeblock,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'accessing-delegated' }
GtOldPillarExecutableCodeblock >> caption [
	| aParagraph |
	aParagraph := super caption.
	aParagraph text ifEmpty: [ 
		^ PRParagraph with: (PRText content: 'Executable script') ].
	^ aParagraph
]

{ #category : #testing }
GtOldPillarExecutableCodeblock >> hasCaption [
	^ self caption text notEmpty
]

{ #category : #testing }
GtOldPillarExecutableCodeblock >> hasLabel [
	^ self label notEmpty
]

{ #category : #'accessing-delegated' }
GtOldPillarExecutableCodeblock >> label [
	^ super label ifEmpty: [ 'Executable script' ]
]
