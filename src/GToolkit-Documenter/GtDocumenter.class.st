Class {
	#name : #GtDocumenter,
	#superclass : #BrEditor,
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
	documenterModel classComment: aClass
]

{ #category : #defaults }
GtDocumenter >> defaultParser [
	^ GtDocumenterParser new
]

{ #category : #defaults }
GtDocumenter >> defaultStorage [
	^ GtStorageStrategy null
]

{ #category : #defaults }
GtDocumenter >> defaultStyler [
	^ GtDocumenterStyler new 
		document: self; 
		parser: self defaultParser;
		hideMarkup
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

{ #category : #'api - storage' }
GtDocumenter >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution.
	It is typically a class in case of class comment, file in case of file content, and nil in other cases."
	<return: #Object>
	^ self storage evaluationReceiver
]

{ #category : #'api - storage' }
GtDocumenter >> fileReference: aFileReference [ 
	documenterModel fileReference: aFileReference
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
	
	self viewModel add: (documenterModel := GtDocumenterModel new).

	self styler: self defaultStyler.
	
	self look: GtDocumenterLook.
	self matchParent.

]

{ #category : #'api - announcer' }
GtDocumenter >> isSubscribedToSystem [
	<return: #Boolean>
	^ documenterModel isSubscribedToSystem
]

{ #category : #'api - storage' }
GtDocumenter >> name [
	<return: #String>
	^ documenterModel name
]

{ #category : #'api - styling' }
GtDocumenter >> normalFontSize [
	<rerturn: #Number>
	^ documenterModel normalFontSize
]

{ #category : #'api - styling' }
GtDocumenter >> normalFontSize: aNumber [
	documenterModel normalFontSize: aNumber.
	self styler fontSize: aNumber.
	self styleTextRequest.
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
	documenterModel read
]

{ #category : #'api - resourcer' }
GtDocumenter >> resourcer [
	^ GtResourceVisitor new document: self
]

{ #category : #'api - storage' }
GtDocumenter >> rootDirectory [
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ documenterModel rootDirectory
]

{ #category : #'api - styling' }
GtDocumenter >> showMarkup [
	self editor styler mode isEditing ifTrue: [ ^ self ].
	self editor styler displayMarkup.
	self styleTextRequest.
]

{ #category : #'api - storage' }
GtDocumenter >> storage [
	<return: #GtStorageStrategy>
	^ documenterModel storage
]

{ #category : #'api - storage' }
GtDocumenter >> store [
	documenterModel store
]

{ #category : #'api - content' }
GtDocumenter >> string [
	<return: #String>
	^ self text asString
]

{ #category : #'api - styling' }
GtDocumenter >> styleTextRequest [
	self editor styleText
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

{ #category : #'api - announcer' }
GtDocumenter >> unsubscribe: aSubscriber [
	^ documenterModel unsubscribe: aSubscriber
]

{ #category : #'api - variables' }
GtDocumenter >> variableBindings [
	<return: #GtSnippetBindings>
	^ documenterModel variableBindings
]
