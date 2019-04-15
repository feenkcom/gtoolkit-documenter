Class {
	#name : #GtCodeblockEvaluatorVisitor,
	#superclass : #GtDocumentVisitor,
	#category : #'GToolkit-Documenter-Code Snippet'
}

{ #category : #accessing }
GtCodeblockEvaluatorVisitor >> document [
	<return: #GtDocument>
	self
		assert: [ document isNotNil ] 
		description: [ 'Document instance must be itialized before using it' ].
	^ document
]

{ #category : #accessing }
GtCodeblockEvaluatorVisitor >> document: aGtDocument [
	self
		assert: [ document isNil ] 
		description: [ 'Document instance must be itialized only once' ].
	self
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document instance must be non-nil' ].
	document := aGtDocument
]

{ #category : #actions }
GtCodeblockEvaluatorVisitor >> evaluateCodeblock: aCodeBlock [
	GtCodeblockEvaluator new
		document: self document;
		node: aCodeBlock;
		text: self document text;
		condition: [ :anEvaluator | anEvaluator isCursorPlacedInTheBody ];
		evaluateSelection
]

{ #category : #'visiting-document' }
GtCodeblockEvaluatorVisitor >> visitCodeblock: aCodeBlock [
	super visitCodeblock: aCodeBlock.
	self evaluateCodeblock: aCodeBlock.
]
