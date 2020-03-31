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

{ #category : #'*GToolkit-Documenter' }
Class >> gtXDocPublishActionFor: anAction [
	<gtAction>
	^ anAction dropdown 
		icon: BrGlamorousIcons tocloud;
		forViewDefinedIn: #gtDocumentFor:;
		priority: 55;
		content: [ (XdPublishInfoStencilBuilder new 
			info: (XdPublishInfo new
				author: '';
				publishAction: [ :aPublishInfo | (GtDocument forClass: self) publishXDocWithInfo: aPublishInfo ])) asElement
					constraintsDo: [ :c | 
					c padding: (BlInsets all: 5).
					c vertical exact: 300.
					c horizontal exact: 200 ]. ]
]
