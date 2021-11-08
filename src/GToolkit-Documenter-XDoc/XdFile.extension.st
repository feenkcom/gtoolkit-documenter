Extension { #name : #XdFile }

{ #category : #'*GToolkit-Documenter-XDoc' }
XdFile >> asDocumenter [
	^ XdDocumenter forXdFile: self
]

{ #category : #'*GToolkit-Documenter-XDoc' }
XdFile >> gtLiveFor: aView [
	<gtView>
	| mainType |
	self exists ifFalse: [ ^ aView empty ].
	mainType := self manifest mainDocument type.
	(mainType isKindOf: XdUndefinedType) ifTrue: [
		^ aView text
			title: 'Live';
			priority: 0;
			text: 'Cannot render unknown document type ''', (mainType typeString), '''.'
	].
	^ aView explicit
		title: 'Live';
		priority: 0;
		stencil: [ XdDocumenter forXdFile: self ];
		actionButtonIcon: BrGlamorousIcons open action: [ self openInPharo ]
]

{ #category : #'*GToolkit-Documenter-XDoc' }
XdFile >> gtSpotterActDefaultFrom: aSpotterElement [
	| aDocumenter aTitle |
	aDocumenter := XdDocumenter forXdFile: self.
	aTitle := self hasTitle 
		ifTrue: [ self title ] 
		ifFalse: [ 'XDoc Document' ].
	(GtPager openWrappedOn: aDocumenter title: aTitle from: aSpotterElement) maximized
]
