Extension { #name : #GtDocumenter }

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocumenter >> gtDecreaseFontSizeActionFor: anAction [
	<gtAction>
	^ anAction button 
		icon: BrGlamorousVectorIcons remove;
		tooltip: 'Decrease font size';
		forViewDefinedIn: #gtLiveFor:;
		priority: 5;
		action: [ self decreaseNormalFontSize ]
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocumenter >> gtIncreaseFontSizeActionFor: anAction [
	<gtAction>
	^ anAction button 
		icon: BrGlamorousVectorIcons add;
		tooltip: 'Increase font size';
		forViewDefinedIn: #gtLiveFor:;
		priority: 6;
		action: [ self increaseNormalFontSize ]
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocumenter >> gtXDocPublishActionFor: anAction [
	<gtAction>
	^ anAction dropdown 
		icon: BrGlamorousIcons tocloud;
		tooltip: 'Publish to Feenk blog';
		forViewDefinedIn: #gtLiveFor:;
		priority: 20;
		content: [ XdDocumenterShareDialogStencil new document: self ]
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocumenter >> saveToXDoc [
	<return: #XdFile>
	^ self saveToXDocWithInformation: XdShareInformation new
]

{ #category : #'*GToolkit-Documenter-XDoc' }
GtDocumenter >> saveToXDocWithInformation: aXdShareInformation [
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
