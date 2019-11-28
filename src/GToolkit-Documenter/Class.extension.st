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
			aDocument gtShowMarkupActionFor: anAction ];
		action: [ :anAction | 
			anAction explicit stencil: [
				| button enabled |
				enabled := (self hasClassVarNamed: #confluenceSpaceName) and: [ self hasClassVarNamed:  #confluencePageName].
				button := BrButton new.
				button
					look: BrGlamorousButtonWithIconLook;
					action: [ 
						| spaceName pageName |
						spaceName := (self classVariableNamed: #confluenceSpaceName) value.
						pageName := (self classVariableNamed: #confluencePageName) value.
						aDocument exportToConfluencePage: pageName inSpace: spaceName
					];
					icon: BrGlamorousIcons tocloud asElement;
					label: 'Upload to Confluence' translated;
					enabled: enabled.
			]
		].
]
