Class {
	#name : #GtDocumenterClyClassCommentEditorTool,
	#superclass : #ClyBrowserToolMorph,
	#instVars : [
		'documenter',
		'editingClass',
		'space',
		'host'
	],
	#category : #'GToolkit-Documenter-Calypso'
}

{ #category : #activation }
GtDocumenterClyClassCommentEditorTool class >> classCommentTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: ClyClassComment asCalypsoItemContext
]

{ #category : #activation }
GtDocumenterClyClassCommentEditorTool class >> classTabActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: ClyClass asCalypsoItemContext
]

{ #category : #testing }
GtDocumenterClyClassCommentEditorTool class >> shouldBeActivatedInContext: aBrowserContext [
	^aBrowserContext isClassSelected
]

{ #category : #accessing }
GtDocumenterClyClassCommentEditorTool class >> tabOrder [
	^  8
]

{ #category : #controlling }
GtDocumenterClyClassCommentEditorTool >> attachToSystem [

	browser system 
		when: (ClyClassChange of: editingClass) send: #triggerUpdate to: self;
		when: (ClyClassComment of: editingClass) send: #triggerUpdate to: self
]

{ #category : #testing }
GtDocumenterClyClassCommentEditorTool >> belongsToCurrentBrowserContext [

	^(browser isClassSelected: editingClass)
		or: [ ^browser isClassSelected: editingClass instanceSide ]
]

{ #category : #testing }
GtDocumenterClyClassCommentEditorTool >> belongsToRemovedBrowserContext [
	^editingClass isObsolete 
]

{ #category : #building }
GtDocumenterClyClassCommentEditorTool >> build [
	self buildDocumenter.
	
	host := BlMorphicHost new.
	host containerMorph: self.
	
	space := BlSpace new.
	space addChild: documenter.
	space host: host.
	space show
]

{ #category : #building }
GtDocumenterClyClassCommentEditorTool >> buildDocumenter [
	| aDocument aPageElement |
	aDocument := GtDocument forClass: editingClass.
	aPageElement := aDocument asElement.
	aPageElement
		addShortcut: (BlShortcut new
			combination: (BlKeyCombination builder meta; key: BlKeyboardKey s; build);
			action: [ :aShortcut | aDocument store ]).
			
	documenter := GtInspector new.
	documenter constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	documenter addPageWithContent: aPageElement for: editingClass comment.
]

{ #category : #initialization }
GtDocumenterClyClassCommentEditorTool >> defaultIconName [
	^(context lastSelectedItem isMarkedWith: ClyNoCommentTag)
		ifTrue: [ #uncommentedClass ]
		ifFalse: [ #commentsIcon]
]

{ #category : #initialization }
GtDocumenterClyClassCommentEditorTool >> defaultTitle [
	^'Document'
]

{ #category : #controlling }
GtDocumenterClyClassCommentEditorTool >> detachFromSystem [

	browser system unsubscribe: self.
	space ifNotNil: [ :aSpace | aSpace hasHostSpace ifTrue: [ space close ] ]
]

{ #category : #initialization }
GtDocumenterClyClassCommentEditorTool >> setUpModelFromContext [
	super setUpModelFromContext.

	editingClass := context lastSelectedClass
]
