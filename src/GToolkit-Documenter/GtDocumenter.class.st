Class {
	#name : #GtDocumenter,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'documenterModel'
	],
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
	^ documenterModel announce: anAnnouncement
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
GtDocumenter >> fileReference: aFileReference [ 
	self editorElement fileReference: aFileReference
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
	self viewModel: (documenterModel := GtDocumenterModel new 
		add: (BrInteractiveModel withAll: {
				BrLayoutHorizontalResizerModel matchParent.
				BrLayoutVerticalResizerModel matchParent })).
	self initializeEditor.

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

{ #category : #'api - announcer' }
GtDocumenter >> isSubscribedToSystem [
	<return: #Boolean>
	^ documenterModel isSubscribedToSystem
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

{ #category : #'hooks - children' }
GtDocumenter >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	documenterModel updateAndSubscribeToSystem
]

{ #category : #'hooks - children' }
GtDocumenter >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	documenterModel unsubscribeFromSystem.
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
	^ documenterModel systemAnnouncer
]

{ #category : #'api - announcer' }
GtDocumenter >> systemSubscriber [
	^ documenterModel
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
	^ documenterModel unsubscribe: aSubscriber
]

{ #category : #'api - variables' }
GtDocumenter >> variableBindings [
	<return: #GtSnippetBindings>
	^ documenterModel variableBindings
]
