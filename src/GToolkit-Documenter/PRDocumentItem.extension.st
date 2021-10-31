Extension { #name : #PRDocumentItem }

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> constants [
	^ GtDocumentConstants
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gt: aString exportFor: aView writer: writer priority: aNumber [

	| result |
	result := aView explicit
		title: aString;
		stencil: [ 
			BrEditorElement new 
				editor: (BrTextEditor new
					text: (writer write: self) asRopedText readonly);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ].
	aNumber ifNotNil: [ result priority: aNumber ].
	^ result
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtAsciiDocExportFor: aView [
	<gtViewExports>
	^ self gt: 'AsciiDoc' exportFor: aView writer: PRAsciiDocWriter priority: nil
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtBeamerExportFor: aView [
	<gtViewExports>
	^ self gt: 'Beamer' exportFor: aView writer: PRBeamerWriter priority: nil
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtDeckJSExportFor: aView [
	<gtViewExports>
	^ self gt: 'DeckJS' exportFor: aView writer: PRDeckJSWriter priority: nil
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtDocument [
	<return: #GtDocumenter>
	^ self propertyAt: #gtDocument
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtDocument: aGt2Document [
	self propertyAt: #gtDocument put: aGt2Document
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtExportsFor: aView [
	<gtView>
	^ aView composite
		title: 'Exports';
		priority: 1;
		collectorDo: [ :aCollector |
			aCollector
				pragmaName: #gtViewExports;
				fromObject: self ]
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtLaTeXExportFor: aView [
	<gtViewExports>
	^ self gt: 'LaTeX' exportFor: aView writer: PRLaTeXWriter priority: nil
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtLaTeXSbaBookExportFor: aView [
	<gtViewExports>
	^ self gt: 'LaTeX (sbabook)' exportFor: aView writer: PRSBALaTeXWriter priority: nil
]

{ #category : #'*GToolkit-Documenter' }
PRDocumentItem >> gtMarkdownExportFor: aView [
	<gtViewExports>
	^ self gt: 'Markdown' exportFor: aView writer: PRMarkdownWriter priority: 2
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
	^ self gt: 'Pillar' exportFor: aView writer: PRPillarWriter priority: 1
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
	^ self gt: 'Text' exportFor: aView writer: PRTextWriter priority: 4
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
