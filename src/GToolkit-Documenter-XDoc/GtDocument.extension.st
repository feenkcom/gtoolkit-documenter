Extension { #name : #GtDocument }

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> deleteXDocWithInformation: aXdShareInformation [
	^ XdClient new 
		username: aXdShareInformation username asString
		password: aXdShareInformation password asString;
		deleteUrl: aXdShareInformation publicUrl asString.
]

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
GtDocument >> publishXDocWithInformation: aXdShareInformation [
	| anXdFile |
	anXdFile := XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		title: aXdShareInformation title asString;
		authorName: aXdShareInformation author asString;
		description: aXdShareInformation description asString;
		write.
	^ XdClient new 
		username: aXdShareInformation username asString
			password: aXdShareInformation password asString;
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

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> updateXDocWithInformation: aXdShareInformation [
	| anXdFile |
	anXdFile := XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		title: aXdShareInformation title asString;
		authorName: aXdShareInformation author asString;
		description: aXdShareInformation description asString;
		write.
	^ XdClient new 
		username: aXdShareInformation username asString
		password: aXdShareInformation password asString;
		update: anXdFile url: aXdShareInformation publicUrl asString.
]
