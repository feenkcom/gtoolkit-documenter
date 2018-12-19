Extension { #name : #Gt2Document }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
Gt2Document >> gtXDocExportActionFor: anAction [
	<gtAction>
	^ anAction button 
		icon: BrGlamorousIcons save;
		forViewDefinedIn: #gtTextFor:;
		priority: 60;
		action: [ :aButton |
			| aXdFile |
			aXdFile := self saveToXDoc.
			aButton fireEvent: (GtPhlowObjectToSpawn new
				object: aXdFile;
				sourceElement: aButton) ]
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
Gt2Document >> saveToXDoc [
	^ XdWriter new
		streamingStrategy: XdStreamingStrategy bytes;
		document: self;
		documentHtml: self;
		write.
]
