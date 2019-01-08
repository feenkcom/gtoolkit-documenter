Extension { #name : #Class }

{ #category : #'*GToolkit-NewDocumenter' }
Class >> gtDocumentFor: aView [
	<gtView>
	| aDocument |
	aDocument := Gt2Document forClass: self. 
	^ (aDocument gtTextFor: aView)
		title: 'Comment';
		priority: -1;
		action: [ :anAction | 
			aDocument gtSaveActionFor: anAction ];
		action: [ :anAction | 
			aDocument gtShowMarkupActionFor: anAction ]
		
]
