Class {
	#name : #GtDocumenterEditor,
	#superclass : #BrEditor,
	#instVars : [
		'normalFontSizeModel',
		'storageModel'
	],
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #'api - storage' }
GtDocumenterEditor >> basename [
	<return: #String>
	^ storageModel basename
]

{ #category : #'api - storage' }
GtDocumenterEditor >> classComment: aClass [
	storageModel classComment: aClass
]

{ #category : #defaults }
GtDocumenterEditor >> defaultParser [
	^ GtDocumenterParser new
]

{ #category : #defaults }
GtDocumenterEditor >> defaultStyler [
	^ GtDocumenterStyler new 
		document: self; 
		parser: self defaultParser;
		hideMarkup
]

{ #category : #'api - initialization' }
GtDocumenterEditor >> document: aGtDocumenter [
	self styler document: aGtDocumenter.
]

{ #category : #'api - storage' }
GtDocumenterEditor >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution.
	It is typically a class in case of class comment, file in case of file content, and nil in other cases."
	<return: #Object>
	^ storageModel evaluationReceiver
]

{ #category : #'api - storage' }
GtDocumenterEditor >> fileReference: aFileReference [ 
	storageModel fileReference: aFileReference
]

{ #category : #initialization }
GtDocumenterEditor >> initialize [
	super initialize.
	self viewModel add: (normalFontSizeModel := GtDocumenterEditorNormalFontSizeModel new).
	self viewModel add: (storageModel := GtDocumenterEditorStorageModel new).
	self styler: self defaultStyler.
]

{ #category : #'api - storage' }
GtDocumenterEditor >> name [
	<return: #String>
	^ storageModel name
]

{ #category : #accessing }
GtDocumenterEditor >> normalFontSize [
	<rerturn: #Number>
	^ normalFontSizeModel normalFontSize
]

{ #category : #accessing }
GtDocumenterEditor >> normalFontSize: aNumber [
	normalFontSizeModel normalFontSize: aNumber
]

{ #category : #'api - storage' }
GtDocumenterEditor >> read [
	^ storageModel read
]

{ #category : #'api - storage' }
GtDocumenterEditor >> rootDirectory [
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ storageModel rootDirectory
]

{ #category : #'api - storage' }
GtDocumenterEditor >> save [
	^ storageModel save
]

{ #category : #'api - storage' }
GtDocumenterEditor >> storage [
	<return: #GtStorageStrategy>
	^ storageModel storage
]

{ #category : #'api - storage' }
GtDocumenterEditor >> store [
	self
		deprecated: 'Please use save method instead.'
		transformWith:
			'`@receiver store'
				-> '`@receiver save'.
	self save
]

{ #category : #'api - styling' }
GtDocumenterEditor >> styleTextRequest [
	self editor styleText
]
