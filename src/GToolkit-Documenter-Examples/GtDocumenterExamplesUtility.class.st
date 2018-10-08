Class {
	#name : #GtDocumenterExamplesUtility,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #'utility - accessing' }
GtDocumenterExamplesUtility class >> arrayOfDocumentPartsFromEditor: aBrTextEditor [ 
	<return: #Array of: #GtPillarDocumentPart>
	| outs |
	outs := self outsFromEditor: aBrTextEditor.
	^ Array new: outs size streamContents: [ :aStream | 
		1 to: outs size do: [ :anIndex | | aSnippet |
			aSnippet := outs documentPartAt: anIndex.
			aStream nextPut: aSnippet.
			self assert: aSnippet index equals: anIndex ] ]
]

{ #category : #'utility - system environment' }
GtDocumenterExamplesUtility class >> createClassNamed: aClassNameString during: aBlockClosure [ 
	"Create a class in a temporary package and execute a block"
	| theClass |
	self
		assert: [ aClassNameString isSymbol ] 
		description: [ 'Class name should be a symbol' ].
	self
		assert: [ aClassNameString size > 1 ] 
		description: [ 'Class name should have at least one character' ].
	self 
		assert: [ (self environment includesKey: aClassNameString) not ]
		description: [ 'Class name should not exists' ].
	self
		assert: [ aBlockClosure notNil ] 
		description: [ 'Valuable object (block closure) should be initialized' ].
	theClass := Object 
		subclass: aClassNameString 
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'GToolkit-DocumenterTemporaryPackage'.
	[ aBlockClosure cull: theClass cull: aClassNameString.
	] ensure: [ theClass ifNotNil: [ theClass removeFromSystem ] ].
]

{ #category : #'utility - accessing' }
GtDocumenterExamplesUtility class >> documentFromTextElement: aBlTextElement [ 
	<return: #GtDocument>
	| aDocument |
	aDocument := aBlTextElement editor styler document.
	self assert: aDocument notNil.
	self assert: aDocument documentParts notNil.
	^ aDocument
]

{ #category : #'utility - accessing' }
GtDocumenterExamplesUtility class >> editorFromTextElement: aBlTextElement [
	<return: #BrTextEditor>
	^ aBlTextElement editor
]

{ #category : #'utility - accessing' }
GtDocumenterExamplesUtility class >> outsFromEditor: aBrTextEditor [ 
	^ aBrTextEditor styler document documentParts
]

{ #category : #'utility - system environment' }
GtDocumenterExamplesUtility class >> subscriberThat: anOneArgBlock in: anAnnouncer [
	<return: #Object>
	^ (self 
		subscriptionThat: [ :eachSubscription | 
			anOneArgBlock cull: eachSubscription subscriber ] 
		in: anAnnouncer) subscriber
]

{ #category : #'utility - system environment' }
GtDocumenterExamplesUtility class >> subscriptionThat: anOneArgBlock in: anAnnouncer [
	<return: #AnnouncementSubscription>
	^ anAnnouncer subscriptions subscriptions detect: anOneArgBlock
]

{ #category : #'utility - accessing' }
GtDocumenterExamplesUtility class >> textElementForPillarFileReference: aFileReference [
	<return: #BrEditorElement>
	| editorElement |
	editorElement := GtDocumenter editorForPillar: aFileReference.
	self assert: editorElement notNil.
	^ editorElement
]
