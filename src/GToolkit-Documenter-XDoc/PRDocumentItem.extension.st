Extension { #name : #PRDocumentItem }

{ #category : #'*GToolkit-Documenter-XDoc' }
PRDocumentItem >> gtHTMLExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'HTML';
		priority: 3;
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (GtHTMLWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]
