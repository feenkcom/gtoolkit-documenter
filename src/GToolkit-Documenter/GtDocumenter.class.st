Class {
	#name : #GtDocumenter,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtDocumentConstants',
	#classTraits : 'TBrLayoutResizable classTrait + TGtDocumentConstants classTrait',
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #'instance creation' }
GtDocumenter class >> forClass: aClass [
	^ self new classComment: aClass; read
]

{ #category : #'instance creation' }
GtDocumenter class >> forFile: aFileReference [
	^ self new fileReference: aFileReference; read
]

{ #category : #'instance creation' }
GtDocumenter class >> forText: aStringOrText [
	^ self new text: aStringOrText
]

{ #category : #'api - announcer' }
GtDocumenter >> announce: anAnnouncement [
	^ self editorElement announce: anAnnouncement
]

{ #category : #'api - ast' }
GtDocumenter >> ast [
	"Message #isPetit2Failure helps to distinguish between a parsed document or a parser error"
	<return: #PRDocument or: #PP2Failure>
	^ PRValidation beSilentDuring: [ 
		self parser parse: self text characters ].
]

{ #category : #'api - storage' }
GtDocumenter >> basename [
	<return: #String>
	^ self editorElement basename
]

{ #category : #'api - user actions' }
GtDocumenter >> browseClass [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (
		GtCodeblockActionVisitor new 
			action: (GtCodeblockBrowseClassAction new 
				document: self;
				text: self text;
				element: self editorElement))
]

{ #category : #'api - user actions' }
GtDocumenter >> browseImplementors [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (
		GtCodeblockActionVisitor new 
			action: (GtCodeblockBrowseImplementorsAction new 
				document: self;
				text: self text;
				element: self editorElement))
]

{ #category : #'api - user actions' }
GtDocumenter >> browseReferences [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (
		GtCodeblockActionVisitor new 
			action: (GtCodeblockBrowseReferencesAction new 
				document: self;
				text: self text;
				element: self editorElement))
]

{ #category : #'api - cache' }
GtDocumenter >> cache [
	"Text attributes can cache values.
	It is not recommended to use this method outside of this object.
	You should use #cachAt:... relevant methods."
	<return: #Dictionary>
	^ self userData at: #documenterCache ifAbsentPut: [ Dictionary new ].
]

{ #category : #'api - cache' }
GtDocumenter >> cacheAt: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self cache at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #'api - cache' }
GtDocumenter >> cacheAt: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	^ self cache at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : #'api - storage' }
GtDocumenter >> classComment: aClass [
	self editorElement classComment: aClass
]

{ #category : #defaults }
GtDocumenter >> defaultStorage [
	^ GtStorageStrategy null
]

{ #category : #'api - styling' }
GtDocumenter >> displayMarkup [
	self
		deprecated: 'Please use showMarkup method instead.'
		transformWith:
			'`@receiver displayMarkup'
				-> '`@receiver showMarkup'.
	self showMarkup
]

{ #category : #'api - user actions' }
GtDocumenter >> doItAndGoSelectionOrAll [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (GtCodeblockActionVisitor new 
		action: (GtCodeblockEvaluator new
			document: self;
			text: self text;
			condition: [ :anEvaluator | anEvaluator isCursorPlacedInTheBody ]))
]

{ #category : #'api - user actions' }
GtDocumenter >> doItSelectionOrAll [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (GtCodeblockActionVisitor new 
		action: (GtCodeblockEvaluator new
			document: self;
			text: self text;
			doNotDisplayResult;
			condition: [ :anEvaluator | anEvaluator isCursorPlacedInTheBody ]))
]

{ #category : #editor }
GtDocumenter >> editor [
	<return: #BrTextEditor>
	^ self editorElement editor
]

{ #category : #editor }
GtDocumenter >> editorElement [
	<return: #BrEditor>
	^ self childNamed: #editor
]

{ #category : #'api - storage' }
GtDocumenter >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution.
	It is typically a class in case of class comment, file in case of file content, and nil in other cases."
	<return: #Object>
	^ self editorElement evaluationReceiver
]

{ #category : #'api - storage' }
GtDocumenter >> exists [
	<return: #Boolean>
	^ self editorElement exists
]

{ #category : #'api - storage' }
GtDocumenter >> fileReference: aFileReference [ 
	self editorElement fileReference: aFileReference
]

{ #category : #'gt-extension' }
GtDocumenter >> gtASTActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousIcons tree;
		tooltip: 'Display AST nodes';
		forViewDefinedIn: #gtLiveFor:;
		priority: 50;
		action: [ :aWidget | aWidget phlow spawnObject: self parse ]
]

{ #category : #'gt-extension' }
GtDocumenter >> gtResourcesFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Resources';
		priority: 0.3;
		painting: [ :aMondrian | 
			| aResource |
			aResource := self resourcer includeDocuments; allDepth; get.
			aMondrian nodes 
				stencil: [ :eachResource |
					BrCard new
						size: 200@100;
						look: BrShadowLook + BrGlamorousLabelLook + BrDescriptionLook 
							+ BrGlamorousWithVerticalResizerLook + BrGlamorousWithHorizontalResizerLook;
						margin: (BlInsets all: 10);
						padding: (BlInsets all: 10);
						background: Color white;
						title: (eachResource document name asRopedText bold);
						description: ((eachResource document text asString 
								first: (100 min: eachResource document text size))
							asRopedText foreground: Color gray);
						action: [ :aBrCard | aBrCard phlow spawnObject: eachResource ] ];
				with: aResource withAllResources.
			aMondrian edges 
				fromRightCenter;
				toLeftCenter;
				connectToAll: #resources.
			aMondrian layout custom: (GtGradHorizontalDominanceCenteredTreeLayout new 
				levelDistance: 50; nodeDistance: 10) ] 
]

{ #category : #'gt-extension' }
GtDocumenter >> gtSaveActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: self constants saveButtonIcon asElement;
		tooltip: 'Save document';
		forViewDefinedIn: #gtLiveFor:;
		priority: 1;
		action: [ self save ]
]

{ #category : #'gt-extension' }
GtDocumenter >> gtShowMarkupActionFor: anAction [
	<gtAction>
	^ anAction toggle
		icon: self constants editButtonIcon;
		tooltip: 'Show/Hide Markups';
		forViewDefinedIn: #gtLiveFor:;
		priority: 3;
		activatedAction: [ self showMarkup ];
		deactivatedAction: [ self hideMarkup ]
]

{ #category : #'api - styling' }
GtDocumenter >> hideMarkup [
	self styler mode isReading ifTrue: [ ^ self ].
	self styler hideMarkup.
	self styleTextRequest
]

{ #category : #initialization }
GtDocumenter >> initialize [
	super initialize.
	self viewModel: (BrInteractiveModel withAll: {
				BrLayoutHorizontalResizerModel matchParent.
				BrLayoutVerticalResizerModel matchParent }).
	self initializeEditor.
	self initializeShortcuts.

	self look: BrLayoutResizerLook inherit.
	self matchParent.
]

{ #category : #initialization }
GtDocumenter >> initializeEditor [
	| anEditor |
	anEditor := GtDocumenterEditor new
		look: GtDocumenterEditorLook + GtDocumenterEditorCompleterLook.
			
	self addChild: anEditor as: #editor.
	
	anEditor document: self.
]

{ #category : #initialization }
GtDocumenter >> initializeShortcuts [

	self editorElement
		addShortcut: (BlShortcut new
			combination: BlKeyCombination primaryM;
			action: [ :anEvent | self browseImplementors ]);
		addShortcut: (BlShortcut new
			combination: BlKeyCombination primaryN;
			action: [ :anEvent | self browseReferences ]);
		addShortcut: (BlShortcut new
			combination: BlKeyCombination primaryB;
			action: [ :anEvent | self browseClass ]);
		addShortcut: (BlShortcut new
			combination: BlKeyCombination primaryD;
			action: [ :anEvent | self doItSelectionOrAll ]);
		addShortcut: (BlShortcut new
			combination: BlKeyCombination primaryG;
			action: [ :anEvent | self doItAndGoSelectionOrAll ])
]

{ #category : #'api - announcer' }
GtDocumenter >> isSubscribedToSystem [
	<return: #Boolean>
	^ self editorElement isSubscribedToSystem
]

{ #category : #'api - storage' }
GtDocumenter >> name [
	<return: #String>
	^ self editorElement name
]

{ #category : #'api - styling' }
GtDocumenter >> normalFontSize [
	<rerturn: #Number>
	^ self editorElement normalFontSize
]

{ #category : #'api - styling' }
GtDocumenter >> normalFontSize: aNumber [
	self editorElement normalFontSize: aNumber.
]

{ #category : #'api - ast' }
GtDocumenter >> parse [
	^ self ast
]

{ #category : #'api - ast' }
GtDocumenter >> parser [
	<return: #GtDocumenterParser>
	^ self styler parser
]

{ #category : #'api - styling' }
GtDocumenter >> privateStyleText [
	"self
		deprecated: 'Please use styleTextRequest method instead.'
		transformWith:
			'`@receiver privateStyleText'
				-> '`@receiver styleTextRequest'."
	self styleTextRequest
]

{ #category : #'api - storage' }
GtDocumenter >> read [
	self editorElement read
]

{ #category : #'api - resourcer' }
GtDocumenter >> resourcer [
	^ GtResourceVisitor new document: self
]

{ #category : #'api - storage' }
GtDocumenter >> rootDirectory [
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ self editorElement rootDirectory
]

{ #category : #'api - storage' }
GtDocumenter >> save [
	self editorElement save
]

{ #category : #'api - styling' }
GtDocumenter >> showMarkup [
	self editorElement styler mode isEditing ifTrue: [ ^ self ].
	self editorElement styler displayMarkup.
	self styleTextRequest.
]

{ #category : #'api - storage' }
GtDocumenter >> storage [
	<return: #GtStorageStrategy>
	^ self editorElement storage
]

{ #category : #'api - storage' }
GtDocumenter >> store [
	self
		deprecated: 'Please use save method instead.'
		transformWith:
			'`@receiver store'
				-> '`@receiver save'.
	self save
]

{ #category : #'api - content' }
GtDocumenter >> string [
	<return: #String>
	^ self text asString
]

{ #category : #'api - styling' }
GtDocumenter >> styleTextRequest [
	self editorElement styleTextRequest
]

{ #category : #editor }
GtDocumenter >> styler [
	<return: #GtDocumenterStyler>
	^ self editorElement styler.
]

{ #category : #'api - announcer' }
GtDocumenter >> systemAnnouncer [
	<return: #Announcer>
	^ self editorElement systemAnnouncer
]

{ #category : #'api - announcer' }
GtDocumenter >> systemSubscriber [
	^ self editorElement systemSubscriber
]

{ #category : #'api - content' }
GtDocumenter >> text [
	<rerturn: #BlText>
	^ self editorElement text
]

{ #category : #'api - content' }
GtDocumenter >> text: aText [
	self editorElement text: aText
]

{ #category : #'api - announcer' }
GtDocumenter >> unsubscribe: aSubscriber [
	^ self editorElement unsubscribe: aSubscriber
]

{ #category : #'api - variables' }
GtDocumenter >> variableBindings [
	<return: #GtSnippetBindings>
	^ self editorElement variableBindings
]