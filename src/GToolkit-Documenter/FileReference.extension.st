Extension { #name : #FileReference }

{ #category : #'*GToolkit-Documenter' }
FileReference >> gtDocumentFor: aView [
	<gtView>
	| aDocument |
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ 
aView empty ].
	self exists ifFalse: [ ^ aView empty ].

	aDocument := GtDocument forFile: self.
	^ (aDocument gtTextFor: aView)
		priority: 9;
		action: [ :anAction | 
			aDocument gtSaveActionFor: anAction ];
		action: [ :anAction | 
			aDocument gtShowMarkupActionFor: anAction ]
]
