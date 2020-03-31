Extension { #name : #Class }

{ #category : #'*GToolkit-Documenter' }
Class >> gtDocumentFor: aView [
	<gtView>
	| aDocument |
	aDocument := GtDocument forClass: self. 
	^ (aDocument gtTextFor: aView)
		title: 'Comment';
		priority: -1;
		action: [ :anAction | 
			aDocument gtSaveActionFor: anAction ];
		action: [ :anAction | 
			aDocument gtShowMarkupActionFor: anAction ].
]
