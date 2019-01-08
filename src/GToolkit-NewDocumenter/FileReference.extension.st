Extension { #name : #FileReference }

{ #category : #'*GToolkit-NewDocumenter' }
FileReference >> gtDocumentFor: aView [
	<gtView>
	| aDocument |
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ 
aView empty ].

	aDocument := Gt2Document forFile: self.
	^ (aDocument gtTextFor: aView)
		priority: 9;
		action: [ :anAction | 
			aDocument gtSaveActionFor: anAction ];
		action: [ :anAction | 
			aDocument gtShowMarkupActionFor: anAction ]
]
