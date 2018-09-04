Extension { #name : #PRDocumentItem }

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtAsciiDocExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'AsciiDoc';
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRAsciiDocWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtBeamerExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'Beamer';
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRBeamerWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtDeckJSExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'DeckJS';
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRDeckJSWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtExportsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Exports';
		stencil: [ 
			| thePragmas aExportsViews aCompositeView |
			thePragmas := Pragma
				allNamed: #gtViewExports
				from: self class
				to: ProtoObject.
			aExportsViews := self gtViewsFromPragmas: thePragmas inContext: nil.
			aCompositeView := GtPhlowView sequentialExplicit composite views: aExportsViews.
			aCompositeView asElementDo: [ :anElement | anElement ]
		]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtHTMLExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'HTML';
		priority: 3;
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRHTMLWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtLaTeXExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'LaTeX';
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRLaTeXWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtLaTeXSbaBookExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'LaTeX (sbabook)';
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRSBALaTeXWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtMarkdownExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'Markdown';
		priority: 2;
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRMarkdownWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtPillarExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'Pillar';
		priority: 1;
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRPillarWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtTextExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'Text';
		priority: 4;
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (PRTextWriter write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]
