Extension { #name : #Gt2Document }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
Gt2Document >> gtXDocPublishActionFor: anAction [
	<gtAction>
	^ anAction dropdown 
		icon: BrGlamorousIcons tocloud;
		forViewDefinedIn: #gtTextFor:;
		priority: 55;
		popup: [ (XdPublishInfoStencilBuilder new 
			info: (XdPublishInfo new
				author: Author fullName;
				publishAction: [ self publishXDoc ])) asElement
					constraintsDo: [ :c | 
					c padding: (BlInsets all: 5).
					c vertical exact: 300.
					c horizontal exact: 200 ]. ];
		action: [ :aButton |
			| aXdFile |
			aXdFile := self publishXDoc. ]
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
Gt2Document >> publishXDoc [
	XdClient new publish: self saveToXDoc
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
Gt2Document >> saveToXDoc [
	^ XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		write.
]
