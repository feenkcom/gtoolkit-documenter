Extension { #name : #GtDocument }

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> gtXDocPublishActionFor: anAction [
	<gtAction>
	^ anAction dropdown 
		icon: BrGlamorousIcons tocloud;
		tooltip: 'Publish to Feenk blog';
		forViewDefinedIn: #gtTextFor:;
		priority: 55;
		content: [ XdDocumenterShareDialogStencil new document: self ]
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> xdocPublisher [
	^ XdDocumenterPublisher forDocument: self
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> xdocSaver [
	^ XdDocumenterSaver forDocument: self
]
