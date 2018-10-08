Class {
	#name : #GtDocumenterClyClassCommentEditorTool,
	#superclass : #ClyBrowserTool,
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
		when: (ClyClassChange of: editingClass) send: #triggerUpdate to: self
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

	documenter := GtDocumenter editorForText: self editingText.
	documenter
		addShortcut: (BlShortcut new
			combination: (BlKeyCombination builder meta; key: Key s; build);
			action: [ :aShortcut | self saveComment ])
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

{ #category : #accessing }
GtDocumenterClyClassCommentEditorTool >> editingText [
	^editingClass  comment asRopedText
]

{ #category : #accessing }
GtDocumenterClyClassCommentEditorTool >> pendingText [
	^ documenter editor text
]

{ #category : #controlling }
GtDocumenterClyClassCommentEditorTool >> saveComment [
	self pendingText asString = self editingText asString
		ifFalse: [ editingClass comment: self pendingText asString stamp: Author changeStamp].

	^true
]

{ #category : #initialization }
GtDocumenterClyClassCommentEditorTool >> setUpModelFromContext [
	super setUpModelFromContext.

	editingClass := context lastSelectedClass
]
