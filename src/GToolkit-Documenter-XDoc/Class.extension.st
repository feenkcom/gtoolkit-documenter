Extension { #name : #Class }

{ #category : #'*GToolkit-Documenter-XDoc' }
Class >> gtXDocPublishActionFor: anAction [
	<gtAction>
	^ anAction dropdown 
		icon: BrGlamorousIcons tocloud;
		forViewDefinedIn: #gtDocumentFor:;
		priority: 55;
		content: [
			 XdDocumenterShareDialogStencil new 
			 	document: (GtDocumenter forClass: self) ].
]
