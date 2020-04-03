Extension { #name : #GtDocument }

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> publishXDoc [
	XdClient new publish: self saveToXDoc
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> publishXDocWithInfo: aXdPublishInfo [
	| anXdFile |
	anXdFile := XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		title: aXdPublishInfo title asString;
		authorName: aXdPublishInfo author asString;
		description: aXdPublishInfo description asString;
		write.
	XdClient new 
		username: aXdPublishInfo username asString
			password: aXdPublishInfo password asString;
		publish: anXdFile
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> saveToXDoc [
	<return: #XdFile>
	^ XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		write.
]
