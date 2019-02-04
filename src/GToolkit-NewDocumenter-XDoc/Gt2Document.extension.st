Extension { #name : #Gt2Document }

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
