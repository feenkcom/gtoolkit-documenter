Extension { #name : #XdFile }

{ #category : #'*GToolkit-Documenter-XDoc' }
XdFile >> gtDocumentFor: aView [
	<gtView>
	self manifest mainDocument type = XdType documenter ifFalse: [ ^ aView empty ].
	^ (self mainFileReference gtDocumentFor: aView)
		priority: -1
]
