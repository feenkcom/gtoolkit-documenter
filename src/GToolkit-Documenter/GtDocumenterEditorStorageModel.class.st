"
I hold ${class:GtStorageStrategy}$ object that knows how to store a specific document.
I am used by ${class:GtDocumenterEditor}$.

"
Class {
	#name : #GtDocumenterEditorStorageModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'storage'
	],
	#category : #'GToolkit-Documenter-! Editor - Model'
}

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> basename [
	<return: #String>
	^ self storage basename
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> classComment: aClass [ 
	self 
		assert: [ aClass notNil ]
		description: [ 'Class to document must be non-nil' ].
	self storage: (GtStorageStrategy classComment: aClass)
]

{ #category : #defaults }
GtDocumenterEditorStorageModel >> defaultStorage [
	^ GtStorageStrategy null
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self storage evaluationReceiver
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> exists [
	<return: #Boolean>
	^ self storage exists
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> fileReference: aFileReference [ 
	self 
		assert: [ aFileReference notNil ]
		description: [ 'Document file reference must be non-nil' ].
	self storage: (GtStorageStrategy fileReference: aFileReference)
]

{ #category : #initialization }
GtDocumenterEditorStorageModel >> initialize [
	super initialize.
	storage := self defaultStorage.
]

{ #category : #initialization }
GtDocumenterEditorStorageModel >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtDocumenterStorageRequest 
		reply: [ :aResponse | aResponse storage: self storage ].
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> name [
	<return: #String>
	^ self storage name
]

{ #category : #notifying }
GtDocumenterEditorStorageModel >> notifyStorageChanged [
	self dispatchEvent: (GtDocumenterStorageChanged new 
		storage: self storage)
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> read [
	self widgetDo: [ :aDocumenter |
		self storage read: aDocumenter ]
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> rootDirectory [
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ self storage rootDirectory
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> save [
	self widgetDo: [ :aDocumenter | self storage save: aDocumenter ]
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> storage [
	<return: #GtStorageStrategy>
	^ storage
]

{ #category : #'api - storage' }
GtDocumenterEditorStorageModel >> storage: aGtStorageStrategy [
	self 
		assert: [ aGtStorageStrategy isNotNil ] 
		description: [ 'Storage strategy must be non-nil' ].
	storage := aGtStorageStrategy.
	self notifyStorageChanged.
]
