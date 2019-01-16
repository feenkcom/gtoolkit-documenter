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
				publishAction: [ :aPublishInfo | self publishXDocWithInfo: aPublishInfo ])) asElement
					constraintsDo: [ :c | 
					c padding: (BlInsets all: 5).
					c vertical exact: 300.
					c horizontal exact: 200 ]. ]
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
Gt2Document >> publishXDoc [
	XdClient new publish: self saveToXDoc
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
Gt2Document >> publishXDocWithInfo: aXdPublishInfo [
	| anXdFile |
	anXdFile := XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		title: aXdPublishInfo title asString;
		authorName: aXdPublishInfo author asString;
		description: aXdPublishInfo description asString;
		write.
	XdClient new publish: anXdFile
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
Gt2Document >> saveToXDoc [
	<return: #XdFile>
	^ XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		write.
]
