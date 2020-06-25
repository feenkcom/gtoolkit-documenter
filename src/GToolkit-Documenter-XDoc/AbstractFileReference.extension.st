Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Documenter-XDoc' }
AbstractFileReference >> gtXDocPublishActionFor: anAction [
	<gtAction>
	^ anAction dropdown 
		icon: BrGlamorousIcons tocloud;
		forViewDefinedIn: #gtDocumentFor:;
		priority: 55;
		content: [
			 XdDocumenterShareDialogStencil new 
			 	document: (GtDocumenter forFile: self) ].
]
