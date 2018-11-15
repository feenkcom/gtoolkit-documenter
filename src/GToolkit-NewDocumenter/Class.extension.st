Extension { #name : #Class }

{ #category : #'*GToolkit-NewDocumenter' }
Class >> gtDocumentFor: aView [
	<gtView>
	^ ((Gt2Document forClass: self) gtTextFor: aView)
		title: 'Comment';
		priority: -1
]
