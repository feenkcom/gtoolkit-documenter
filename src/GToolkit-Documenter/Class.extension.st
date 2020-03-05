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
		actionDropdownButtonIcon: BrGlamorousIcons tocloud asElement
		label: nil 
		content: [ :b | 
			| content  labelAndInput|
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
			content := BlElement new
				layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 10);
				constraintsDo: [ :c |
					c horizontal matchParent .
					c vertical fitContent ];
				addChildren: (labelAndInput value: 'URL:');
				addChildren: (labelAndInput value: 'Username:');
				addChildren: (labelAndInput value: 'Password:').
			
			BlElement new 
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
						action: [])].
]
