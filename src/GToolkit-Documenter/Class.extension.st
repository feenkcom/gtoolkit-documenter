Extension { #name : #Class }

{ #category : #'*GToolkit-Documenter' }
Class >> gtConfluenceCredentialsForm [
	| content  labelAndInput url password username |
	labelAndInput := [ :label |
		{ 
			BrLabel new look: (BrGlamorousLabelLook new foreground: Color gray);
				padding: (BlInsets top: 0 right: 20 bottom: 2 left: 0);
				text: (label asRopedText glamorousRegularFont readonly).
			BrEditor new 
				look: BrGlamorousCodeEditorLook;
				margin: (BlInsets bottom: 1);
				border: (BlBorder paint: Color gray width: 0.5).
		}
	]. 
	url := labelAndInput value: 'URL:'.
	username := labelAndInput value: 'Username:'.
	password := labelAndInput value: 'Password:'.
	content := BlElement new
		layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 10);
			constraintsDo: [ :c |
				c horizontal matchParent .
				c vertical fitContent ];
			addChildren: url;
			addChildren: username;
			addChildren: password.
			
	^ BlElement new 
		constraintsDo: [:c | 
			c horizontal exact: 300. 
			c vertical fitContent. ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets all: 10);
		addChild: content;
		addChild: (
			BrButton new
				constraintsDo: [ :c |
					c linear horizontal alignRight ];
				margin: (BlInsets top: 10 right: 10 bottom: 0 left: 0);
				look: BrGlamorousButtonWithIconLook; 
				icon: BrGlamorousIcons save asElement; 
				label: 'Save'; 
				action: [
					Smalltalk at: #confluenceURL put: (url at: 2) text asString.
					Smalltalk at: #confluenceUsername put: (username at: 2) text asString.
					Smalltalk at: #confluencePassword put: (password at: 2) text asString.
		]).
]

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
		actionDropdownButtonIcon: BrGlamorousIcons tocloud asElement
		label: nil 
		content: [ :b | self gtConfluenceCredentialsForm ].
]
