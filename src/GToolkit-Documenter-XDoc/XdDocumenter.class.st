Class {
	#name : #XdDocumenter,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'xdFile',
		'resizer'
	],
	#category : #'GToolkit-Documenter-XDoc-! Documenter'
}

{ #category : #'api - instance creation' }
XdDocumenter class >> forXdFile: anXdFile [
	^ self new xdFile: anXdFile
]

{ #category : #'private - accessing' }
XdDocumenter >> contentElement [
	<rerturn: #GtDocumenter>
	^ self childNamed: self defaultDocumentContentChildName
]

{ #category : #defaults }
XdDocumenter >> defaultDocumentContentChildName [
	^ #documentContent
]

{ #category : #defaults }
XdDocumenter >> defaultHeaderChildName [
	^ #details
]

{ #category : #defaults }
XdDocumenter >> defaultTitleChildName [
	^ #title
]

{ #category : #defaults }
XdDocumenter >> defaultXdFile [
	^ XdFile null
]

{ #category : #'private - accessing' }
XdDocumenter >> headerElement [
	<return: #XdDocumenterHeader>
	^ self childNamed: self defaultHeaderChildName
]

{ #category : #initialization }
XdDocumenter >> initialize [
	super initialize.
	xdFile := self defaultXdFile.
		
	self initializeTitle.
	self initializeHeader.
	
	self matchParent.
	self layout: BlLinearLayout vertical.
	self padding: (BlInsets all: 10).
	self aptitude: (resizer := BrLayoutResizerAptitude inherit hInherit: self headerElement)
]

{ #category : #initialization }
XdDocumenter >> initializeHeader [
	| aHeader |
	aHeader := XdDocumenterHeader new.
	aHeader labeled: 'Header'.
	aHeader aptitude: GtCoderExpanderWithoutShadowAptitude.
	aHeader margin: (BlInsets bottom: 10).
	aHeader padding: (BlInsets all: 7).
	aHeader hMatchParent; vFitContent.
	self addChild: aHeader as: self defaultHeaderChildName.
	
]

{ #category : #initialization }
XdDocumenter >> initializeTitle [
	| aHeader |
	aHeader := BrEditor new 
		aptitude: BrGlamorousEditorAptitude;
		beReadOnlyWithSelection;
		text: self titleText;
		hMatchParent;
		vFitContent.
	aHeader labeled: 'Title'.
	self addChild: aHeader as: self defaultTitleChildName.
]

{ #category : #hooks }
XdDocumenter >> onXdFileChanged [
	| aTool anElement |
	self titleElement text: self titleText.
	self headerElement xdFile: self xdFile.
	aTool := self xdFile toolInPharo.
	aTool ifNil: [ ^ self ].
	
	anElement := aTool asElement.
	resizer inherit: anElement.
	anElement labeled: 'Content'.
	
	self removeChildNamed: self defaultDocumentContentChildName.
	self addChild: anElement as: self defaultDocumentContentChildName.
]

{ #category : #'private - accessing' }
XdDocumenter >> titleElement [
	<return: #BlText>
	^ self childNamed: self defaultTitleChildName
]

{ #category : #'private - text' }
XdDocumenter >> titleText [
	<return: #BlText>
	^ self xdFile hasTitle
		ifTrue: [ self xdFile title asRopedText
			glamorousRegularFont;
			fontSize: 24;
			bold ]
		ifFalse: [ '' asRopedText ]
]

{ #category : #'api - accessing' }
XdDocumenter >> xdFile [
	<return: #XdFile>
	^ xdFile
]

{ #category : #'api - accessing' }
XdDocumenter >> xdFile: aXdFile [
	self 
		assert: [ aXdFile isNotNil ]
		description: [ 'XdFile must be non-nil' ].
	xdFile := aXdFile.
	self onXdFileChanged.
]
