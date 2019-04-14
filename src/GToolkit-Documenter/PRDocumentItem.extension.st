Extension { #name : #PRDocumentItem }

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> constants [
	^ GtDocumentConstants
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> cursorLeftInText: aBlRopedText [ 
	"Subclasses can add behavior"
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> cursorNearbyInText: aBlRope [
	"Subclasses can update it"
]

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
PRDocumentItem >> gtDocument [
	<return: #GtDocument>
	^ self propertyAt: #gtDocument
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtDocument: aGt2Document [
	self propertyAt: #gtDocument put: aGt2Document
]

{ #category : #'*GToolkit-Documenter' }
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
PRDocumentItem >> gtListItemStyler [
	<return: #GtListItemStyler>
	^ self propertyAt: #gtListItemStyler
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtListItemStyler: aGt2ListItemStyler [
	self propertyAt: #gtListItemStyler put: aGt2ListItemStyler
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtMarkdownExportFor: aView [
	<gtViewExports>
	^ aView explicit
		title: 'Markdown';
		priority: 2;
		stencil: [ 
			| aString | 
			[ aString := PRMarkdownWriter write: self ] on: Warning do: [ :anException | anException resume ].
			aString ifNil: [ aString := '' ].
			BrEditorElement new 
				editor: (BrTextEditor new
					text: aString asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtNodeFinder [
	^ GtNodeNodeFinder new
		node: self
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtNodeStyler: aBlText [
	^ GtStyledNodeBuilder new 
		document: self gtDocument; 
		node: self; 
		text: aBlText
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
PRDocumentItem >> gtSubscriber [
	<return: #Object>
	^ self propertyAt: #gtSubscriber
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtSubscriber: anObject [
	self propertyAt: #gtSubscriber put: anObject
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

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> styleText: aBlRope using: aGt2StylerStrategy [
	aGt2StylerStrategy styleText: aBlRope withNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> styleTextWithMarkup: aBlRope [
	"Subclasses can add text styling for Documenter editing mode"
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> styleTextWithoutInteractions: aBlRope [
	"Subclasses can add text styling for Documenter reading mode"
	self styleTextWithoutMarkup: aBlRope 

]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> styleTextWithoutMarkup: aBlRope [ 
	"Subclasses can add text styling for Documenter reading mode"
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> utility [
	^ GtDocumentUtility
]
