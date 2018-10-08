Class {
	#name : #GtDocExampleExamples,
	#superclass : #GtDocAbstractExamples,
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #'adding non-existent example class' }
GtDocExampleExamples >> addAnotherNonExistentExampleClass [
	<gtExample>
	<label: 'Add another non-existent example class'>
	| aDocument aPillarNode anAnnouncements |
	aDocument := self documentWithNonExistentExampleClass.
	aPillarNode := GtDocumenterExamplesUtility 
		subscriberThat: [ :eachSubscriber | eachSubscriber class = GtPillarExampleAnnotation ] 
		in: aDocument systemChangesHandler announcer.
	self assert: aPillarNode isMethodClassDefined not.
	anAnnouncements := OrderedCollection new.
	aPillarNode subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtDocumenterExamplesUtility 
		createClassNamed: (aPillarNode methodClassName, 'Two') asSymbol
		during: [ 
			self assert: anAnnouncements isEmpty.
			self assert: aPillarNode isMethodClassDefined not.
			self assert: aPillarNode isMethodDefined not ].
	self assert: anAnnouncements isEmpty.
	^ aPillarNode
]

{ #category : #'adding non-existent example class' }
GtDocExampleExamples >> addNonExistentExampleClass [
	<gtExample>
	<label: 'Add non-existent example class'>
	| aDocument aPillarNode anAnnouncements |
	aDocument := self documentWithNonExistentExampleClass.
	aPillarNode := GtDocumenterExamplesUtility 
		subscriberThat: [ :eachSubscriber | eachSubscriber class = GtPillarExampleAnnotation ] 
		in: aDocument systemChangesHandler announcer.
	self assert: aPillarNode isMethodClassDefined not.
	anAnnouncements := OrderedCollection new.
	aPillarNode subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtDocumenterExamplesUtility 
		createClassNamed: aPillarNode methodClassName 
		during: [ 
			self assert: anAnnouncements size equals: 1.
			self assert: anAnnouncements first class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aPillarNode.
			self assert: anAnnouncements first document equals: aPillarNode document.
			self assert: aPillarNode isMethodClassDefined.
			self assert: aPillarNode isMethodDefined not ].
	self assert: anAnnouncements size equals: 2.
	self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements second codeSnippet equals: aPillarNode.
	self assert: anAnnouncements second document equals: aPillarNode document.
	^ aPillarNode
]

{ #category : #'adding non-existent example class' }
GtDocExampleExamples >> addNonExistentExampleMethod [
	<gtExample>
	<label: 'Add non-existent example method'>
	| aDocument aPillarNode anAnnouncements |
	aDocument := self documentWithNonExistentExampleClass.
	aPillarNode := GtDocumenterExamplesUtility 
		subscriberThat: [ :eachSubscriber | eachSubscriber class = GtPillarExampleAnnotation ] 
		in: aDocument systemChangesHandler announcer.
	self assert: aPillarNode isMethodClassDefined not.
	self assert: aPillarNode isMethodDefined not.
	anAnnouncements := OrderedCollection new.
	aPillarNode subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtDocumenterExamplesUtility 
		createClassNamed: aPillarNode methodClassName 
		during: [ :theClass | 
			self assert: anAnnouncements size equals: 1.
			theClass 
				compile: aPillarNode methodDefinition selector, String cr, String tab, '<gtExample>'
				classified: 'example'.
			self assert: anAnnouncements size equals: 2.
			self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aPillarNode.
			self assert: anAnnouncements first document equals: aPillarNode document.
			self assert: aPillarNode isMethodClassDefined.
			self assert: aPillarNode isMethodDefined ].
	self assert: anAnnouncements size equals: 3.
	self assert: anAnnouncements third class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements third codeSnippet equals: aPillarNode.
	self assert: anAnnouncements third document equals: aPillarNode document.
	^ aPillarNode
]

{ #category : #'empty example definition' }
GtDocExampleExamples >> documentWithEmptyDefinition [
	<gtExample>
	<label: 'Document with an example with empty definition'>
	| aTextElement aDocument |
	aTextElement := self textElementWithEmptyDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument
]

{ #category : #'example with empty show definition' }
GtDocExampleExamples >> documentWithEmptyShowParameter [
	<gtExample>
	<label: 'Document with an example with an empty show parameter'>
	| aTextElement aDocument |
	aTextElement := self textElementWithEmptyShowParameter.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument
]

{ #category : #'example with expanded preview' }
GtDocExampleExamples >> documentWithExpandedPreview [
	<gtExample>
	<label: 'Document with an example with expanded preview'>
	| aTextElement aDocument |
	aTextElement := self textElementWithExpandedPreview.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument
]

{ #category : #'example with noCode parameter' }
GtDocExampleExamples >> documentWithNoCodeParameter [
	<gtExample>
	<label: 'Document with an example'>
	| aTextElement aDocument |
	aTextElement := self textElementWithNoCodeParameter.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument
]

{ #category : #'non-existent example class' }
GtDocExampleExamples >> documentWithNonExistentExampleClass [
	<gtExample>
	<label: 'Document with an example with non-existent example class'>
	| aTextElement aDocument |
	aTextElement := self textElementWithNonExistentExampleClass.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument
]

{ #category : #'non-existent example method' }
GtDocExampleExamples >> documentWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Document with an example with non-existent example method'>
	| aTextElement aDocument |
	aTextElement := self textElementWithNonExistentExampleMethod.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument
]

{ #category : #'simple example definition' }
GtDocExampleExamples >> documentWithOneExampleCodeSnippet [
	<gtExample>
	<label: 'Document with an example code snippet'>
	| aTextElement aDocument |
	aTextElement := self textElementWithOneExampleCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument
]

{ #category : #'partial example definition' }
GtDocExampleExamples >> documentWithPartialDefinition [
	<gtExample>
	<label: 'Document with an example with partial definition'>
	| aTextElement aDocument |
	aTextElement := self textElementWithPartialDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument
]

{ #category : #'empty example definition' }
GtDocExampleExamples >> fileReferenceWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar file reference with an example with empty definition'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithEmptyDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'example with empty show definition' }
GtDocExampleExamples >> fileReferenceWithEmptyShowParameter [
	<gtExample>
	<label: 'Pillar file reference with an example with an empty show parameter'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithEmptyShowParameter.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'example with expanded preview' }
GtDocExampleExamples >> fileReferenceWithExpandedPreview [
	<gtExample>
	<label: 'Pillar file reference with an example with expanded preview'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExpandedPreview.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'example with noCode parameter' }
GtDocExampleExamples >> fileReferenceWithNoCodeParameter [
	<gtExample>
	<label: 'Pillar file reference with an example'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNoCodeParameter.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'non-existent example class' }
GtDocExampleExamples >> fileReferenceWithNonExistentExampleClass [
	<gtExample>
	<label: 'Pillar file reference with an example with non-existent example class'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistentExampleClass.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'non-existent example method' }
GtDocExampleExamples >> fileReferenceWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Pillar file reference with an example with non-existent example method'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistentExampleMethod.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'simple example definition' }
GtDocExampleExamples >> fileReferenceWithOneExampleCodeSnippet [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithOneExampleCodeSnippet.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'partial example definition' }
GtDocExampleExamples >> fileReferenceWithPartialDefinition [
	<gtExample>
	<label: 'Pillar file reference with an example with partial definition'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithPartialDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'empty example definition' }
GtDocExampleExamples >> pillarContentWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar content with empty definition'>
	^ '${example:}$'
]

{ #category : #'example with empty show definition' }
GtDocExampleExamples >> pillarContentWithEmptyShowParameter [
	<gtExample>
	<label: 'Pillar content with an example with an empty show parameter'>
	^ '${example:' , self referencedExampleMethodName , '|show=}$'
]

{ #category : #'example with expanded preview' }
GtDocExampleExamples >> pillarContentWithExpandedPreview [
	<gtExample>
	<label: 'Pillar content with an example with expanded preview'>
	^ '${example:', self referencedExampleMethodName, '|', self constants expandedPreviewParemeterName, '}$'

]

{ #category : #'example with noCode parameter' }
GtDocExampleExamples >> pillarContentWithNoCodeParameter [
	<gtExample>
	<label: 'Pillar content with an example'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants exampleTag;
			nextPutAll: ':';
			nextPutAll: self referencedExampleMethodName;
			nextPutAll: '|';
			nextPutAll: self constants doNotDisplaySourceCodeParameterName;
			nextPutAll: '}$' ]
]

{ #category : #'non-existent example class' }
GtDocExampleExamples >> pillarContentWithNonExistentExampleClass [
	<gtExample>
	<label: 'Pillar content with non-existent example class'>
	^ '${example:GtDocumenterNonExistentClass>>#nonExistentMethod}$'

]

{ #category : #'non-existent example method' }
GtDocExampleExamples >> pillarContentWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Pillar content with non-existent example method'>
	^ '${example:', self className, '>>#nonExistentMethod}$'
]

{ #category : #'simple example definition' }
GtDocExampleExamples >> pillarContentWithOneExampleCodeSnippet [
	<gtExample>
	<label: 'Pillar content with an example code snippet'>
	^ '${example:', self referencedExampleMethodName, '}$'
]

{ #category : #'partial example definition' }
GtDocExampleExamples >> pillarContentWithPartialDefinition [
	<gtExample>
	<label: 'Pillar content with partial definition'>
	^ '${example:', self className ,'}$'
]

{ #category : #accessing }
GtDocExampleExamples >> referencedExampleMethodName [
	^ (self class >> #pillarContentWithOneExampleCodeSnippet) name
]

{ #category : #'empty example definition' }
GtDocExampleExamples >> textElementWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar element with an example with empty definition'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	aTextElement := GtDocumenterExamplesUtility 
			textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'example with empty show definition' }
GtDocExampleExamples >> textElementWithEmptyShowParameter [
	<gtExample>
	<label: 'Pillar element with an example with an empty show parameter'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithEmptyShowParameter.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'example with expanded preview' }
GtDocExampleExamples >> textElementWithExpandedPreview [
	<gtExample>
	<label: 'Pillar element with an example with expanded preview'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithExpandedPreview.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'example with noCode parameter' }
GtDocExampleExamples >> textElementWithNoCodeParameter [
	<gtExample>
	<label: 'Pillar element with an example'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithNoCodeParameter.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'non-existent example class' }
GtDocExampleExamples >> textElementWithNonExistentExampleClass [
	<gtExample>
	<label: 'Pillar element with an example with non-existent example class'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithNonExistentExampleClass.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'non-existent example method' }
GtDocExampleExamples >> textElementWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Pillar element with an example with non-existent example method'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithNonExistentExampleMethod.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'simple example definition' }
GtDocExampleExamples >> textElementWithOneExampleCodeSnippet [
	<gtExample>
	<label: 'Pillar element with an example code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithOneExampleCodeSnippet.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	^ aTextElement
]

{ #category : #'partial example definition' }
GtDocExampleExamples >> textElementWithPartialDefinition [
	<gtExample>
	<label: 'Pillar element with an example with partial definition'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithPartialDefinition.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]
