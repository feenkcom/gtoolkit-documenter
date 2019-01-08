Extension { #name : #PRDocumentItem }

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> constants [
	^ Gt2DocumentConstants
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> cursorLeftInText: aBlRopedText [ 
	"Subclasses can add behavior"
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> cursorNearbyInText: aBlRope [
	"Subclasses can update it"
]

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtDocument [
	<return: #Gt2Document>
	^ self propertyAt: #gtDocument
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtDocument: aGt2Document [
	self propertyAt: #gtDocument put: aGt2Document
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtExportsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Exports';
		priority: 1;
		stencil: [ 
			| aExportsViews aCompositeView |
			aExportsViews :=  GtPhlowViewsCollector new
				pragmaName: #gtViewExports;
				fromObject: self;
				collect.
			aCompositeView := GtPhlowView empty composite views: aExportsViews.
			aCompositeView asElementDo: [ :anElement | anElement ]
		]
]

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtListItemStyler [
	<return: #Gt2ListItemStyler>
	^ self propertyAt: #gtListItemStyler
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtListItemStyler: aGt2ListItemStyler [
	self propertyAt: #gtListItemStyler put: aGt2ListItemStyler
]

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtSubscriber [
	<return: #Object>
	^ self propertyAt: #gtSubscriber
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtSubscriber: anObject [
	self propertyAt: #gtSubscriber put: anObject
]

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> styleText: aBlRope using: aGt2StylerStrategy [
	aGt2StylerStrategy styleText: aBlRope withNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> styleTextWithMarkup: aBlRope [
	"Subclasses can add text styling for Documenter editing mode"
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> styleTextWithoutMarkup: aBlRope [ 
	"Subclasses can add text styling for Documenter reading mode"
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> utility [
	^ Gt2DocumentUtility
]
