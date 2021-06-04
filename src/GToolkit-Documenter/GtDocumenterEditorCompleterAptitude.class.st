"
I install {{gtClass:GtDocumentCompletionStrategy}} on {{gtClass:GtDocumenterEditor}}.
I am used by {{gtClass:GtDocumenterEditor}}.


"
Class {
	#name : #GtDocumenterEditorCompleterAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'storage',
		'completionStrategy',
		'completionController'
	],
	#category : #'GToolkit-Documenter-! Editor - Look'
}

{ #category : #initialization }
GtDocumenterEditorCompleterAptitude >> initialize [
	super initialize.
	completionStrategy := GtDocumentCompletionStrategy new.
	completionStrategy
		fileReference: GtStorageStrategy null rootDirectory.
	completionController := GtCompletionController new
		strategy: completionStrategy.
	self
		addChange:
			(BrLookChange new
				up: [ :aLook | self installControllerOn: aLook widget ];
				down: [ :aLook | self uninstallControllerOn: aLook widget ])
]

{ #category : #initialization }
GtDocumenterEditorCompleterAptitude >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtDocumenterStorageChanged 
		do: [ :anEvent | self storage: anEvent storage ].
]

{ #category : #initialization }
GtDocumenterEditorCompleterAptitude >> initializeRequests [
	super initializeRequests.

	self request: GtDocumenterStorageRequest new.
]

{ #category : #private }
GtDocumenterEditorCompleterAptitude >> installControllerOn: aDocumenterEditor [
	completionController textElement: aDocumenterEditor.
	completionController install.

]

{ #category : #accessing }
GtDocumenterEditorCompleterAptitude >> onStorageChange [
	completionStrategy fileReference: self storage rootDirectory.
]

{ #category : #accessing }
GtDocumenterEditorCompleterAptitude >> storage [
	<return: #GtStorageStrategy>
	^ storage
]

{ #category : #accessing }
GtDocumenterEditorCompleterAptitude >> storage: aGtStorageStrategy [
	self 
		assert: [ aGtStorageStrategy isNotNil ] 
		description: [ 'Storage strategy must be non-nil' ].
	storage := aGtStorageStrategy.
	self onStorageChange.
]

{ #category : #private }
GtDocumenterEditorCompleterAptitude >> uninstallControllerOn: anElement [
	completionController uninstall.
	completionController textElement: nil.
]
