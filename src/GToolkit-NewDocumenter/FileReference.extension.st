Extension { #name : #FileReference }

{ #category : #'*GToolkit-NewDocumenter' }
FileReference >> gtDocumentFor: aView [
	<gtView>
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ aView empty ].

	^ ((Gt2Document forFile: self) gtTextFor: aView)
		priority: 9
]
