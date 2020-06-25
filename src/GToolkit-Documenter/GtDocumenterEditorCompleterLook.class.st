Class {
	#name : #GtDocumenterEditorCompleterLook,
	#superclass : #BrLook,
	#instVars : [
		'storage',
		'completionStrategy',
		'completionController'
	],
	#category : #'GToolkit-Documenter-! Editor - Look'
}

{ #category : #initialization }
GtDocumenterEditorCompleterLook >> initialize [
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
GtDocumenterEditorCompleterLook >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtDocumenterStorageChanged 
		do: [ :anEvent | self storage: anEvent storage ].
]

{ #category : #initialization }
GtDocumenterEditorCompleterLook >> initializeRequests [
	super initializeRequests.

	self request: GtDocumenterStorageRequest new.
]

{ #category : #private }
GtDocumenterEditorCompleterLook >> installControllerOn: aDocumenterEditor [
	completionController textElement: aDocumenterEditor.
	completionController install.

]

{ #category : #accessing }
GtDocumenterEditorCompleterLook >> onStorageChange [
	completionStrategy fileReference: self storage rootDirectory.
]

{ #category : #accessing }
GtDocumenterEditorCompleterLook >> storage [
	<return: #GtStorageStrategy>
	^ storage
]

{ #category : #accessing }
GtDocumenterEditorCompleterLook >> storage: aGtStorageStrategy [
	self 
		assert: [ aGtStorageStrategy isNotNil ] 
		description: [ 'Storage strategy must be non-nil' ].
	storage := aGtStorageStrategy.
	self onStorageChange.
]

{ #category : #private }
GtDocumenterEditorCompleterLook >> uninstallControllerOn: anElement [
	completionController uninstall.
	completionController textElement: nil.
]
