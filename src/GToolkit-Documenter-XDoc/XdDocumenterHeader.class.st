Class {
	#name : #XdDocumenterHeader,
	#superclass : #BrExpander,
	#instVars : [
		'xdFile',
		'headerEditor',
		'contentEditor'
	],
	#category : #'GToolkit-Documenter-XDoc-! Documenter'
}

{ #category : #'private - text' }
XdDocumenterHeader >> contentText [
	<return: #BlText>
	| aText |
	aText := self headerText.
	aText := aText
		, (String cr , String cr) asRopedText glamorousRegularFontAndSize.
	self xdFile hasDescription
		ifTrue: [ aText := aText
				, self xdFile description asRopedText glamorousRegularFontAndSize ].
	self xdFile hasPublicUrl
		ifTrue: [ | aLink |
			aText := aText
				, (String cr , String cr) asRopedText glamorousRegularFontAndSize.
			aLink := self xdFile publicUrl asString asRopedText
				glamorousRegularFontAndSize.
			aLink
				attribute:
					(BrTextAdornmentDynamicAttribute new
						beReplace;
						stencil: [ BrButton new
								aptitude:
									(BrGlamorousLinkSquaredButtonWithLabelAptitude new
										foreground: self theme button disabledTextColor);
								padding:
									(BlInsets
										top: 3
										left: 3
										bottom: 3
										right: 3);
								geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
								action: [ WebBrowser openOn: self xdFile publicUrl asString ];
								label: self xdFile publicUrl asString asRopedText ]).
			aText := aText , aLink ].
	aText foreground: self theme button disabledTextColor.
	^ aText
]

{ #category : #defaults }
XdDocumenterHeader >> defaultXdFile [
	^ XdFile null
]

{ #category : #'private - text' }
XdDocumenterHeader >> headerText [
	<return: #BlText>
	| aText |
	aText := '' asRopedText.
	self xdFile hasAuthor
		ifTrue: [ aText := aText
				, ('By ' , self xdFile author) asRopedText glamorousRegularFontAndSize ].
	self xdFile hasPublicationDate
		ifTrue: [ aText
				,
					(' on ' , self xdFile publicationDate asDate asString) asRopedText
						glamorousRegularFontAndSize ].
	aText foreground: self theme button disabledTextColor.
	^ aText
]

{ #category : #initialization }
XdDocumenterHeader >> initialize [
	super initialize.
	xdFile := self defaultXdFile.
	self initializeStencils.
]

{ #category : #initialization }
XdDocumenterHeader >> initializeStencils [
	headerEditor := BrEditor new 
		aptitude: BrGlamorousEditorAptitude;
		beReadOnlyWithSelection;
		text: self headerText;
		hMatchParent;
		vFitContent.
	contentEditor :=  BrEditor new 
		aptitude: BrGlamorousEditorAptitude;
		beReadOnlyWithSelection;
		text: self contentText;
		hMatchParent;
		vFitContent.
	self header: headerEditor.
	self content: contentEditor.
]

{ #category : #hooks }
XdDocumenterHeader >> onXdFileChanged [
	headerEditor text: self headerText.
	contentEditor text: self contentText.
]

{ #category : #'api - xdoc file' }
XdDocumenterHeader >> xdFile [
	<return: #XdFile>
	^ xdFile
]

{ #category : #'api - xdoc file' }
XdDocumenterHeader >> xdFile: aXdFile [
	self 
		assert: [ aXdFile isNotNil ]
		description: [ 'XdFile must be non-nil' ].
	xdFile := aXdFile.
	self onXdFileChanged.
]
