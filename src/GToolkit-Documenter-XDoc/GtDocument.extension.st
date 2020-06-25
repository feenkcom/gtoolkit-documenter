Extension { #name : #GtDocument }

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> deleteXDocWithInformation: aXdShareInformation [
	^ XdClient new 
		username: aXdShareInformation username asString
		password: aXdShareInformation password asString;
		deleteUrl: aXdShareInformation publicUrl asString.
]

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
GtDocument >> publishXDocWithInformation: aXdShareInformation [
	| anXdFile |
	anXdFile := self saveToXDocWithInformation: aXdShareInformation.
	^ XdClient new 
		username: aXdShareInformation username asString
			password: aXdShareInformation password asString;
		publish: anXdFile
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> saveToXDoc [
	<return: #XdFile>
	^ self saveToXDocWithInformation: XdShareInformation new
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> saveToXDocWithInformation: aXdShareInformation [
	<return: #XdFile>
	^ XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		preview;
		title: aXdShareInformation title asString;
		authorName: aXdShareInformation author asString;
		description: aXdShareInformation description asString;
		write.
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocument >> updateXDocWithInformation: aXdShareInformation [
	| anXdFile |
	anXdFile := self saveToXDocWithInformation: aXdShareInformation.
	^ XdClient new 
		username: aXdShareInformation username asString
		password: aXdShareInformation password asString;
		update: anXdFile url: aXdShareInformation publicUrl asString.
]
