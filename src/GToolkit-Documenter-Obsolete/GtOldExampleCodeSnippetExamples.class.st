Class {
	#name : #GtOldExampleCodeSnippetExamples,
	#superclass : #GtOldDebuggableCodeSnippetExamples,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'adding non-existent example class' }
GtOldExampleCodeSnippetExamples >> addAnotherNonExistentExampleClass [
	<gtExample>
	<label: 'Add another non-existent example class'>
	| aCodeSnippet anAnnouncements |
	aCodeSnippet := self codeSnippetOfDocumentWithNonExistentExampleClass.
	self assert: aCodeSnippet isMethodClassDefined not.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtOldDocumenterExamplesUtility 
		createClassNamed: (aCodeSnippet methodClassName, 'Two') asSymbol
		during: [ 
			self assert: anAnnouncements isEmpty.
			self assert: aCodeSnippet isMethodClassDefined not.
			self assert: aCodeSnippet isMethodDefined not ].
	self assert: anAnnouncements isEmpty.
	^ aCodeSnippet
]

{ #category : #'adding non-existent example class' }
GtOldExampleCodeSnippetExamples >> addNonExistentExampleClass [
	<gtExample>
	<label: 'Add non-existent example class'>
	| aCodeSnippet anAnnouncements |
	aCodeSnippet := self codeSnippetOfDocumentWithNonExistentExampleClass.
	self assert: aCodeSnippet isMethodClassDefined not.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtOldDocumenterExamplesUtility 
		createClassNamed: aCodeSnippet methodClassName 
		during: [ 
			self assert: anAnnouncements size equals: 1.
			self assert: anAnnouncements first class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
			self assert: anAnnouncements first document equals: aCodeSnippet bindings.
			self assert: aCodeSnippet isMethodClassDefined.
			self assert: aCodeSnippet isMethodDefined not ].
	self assert: anAnnouncements size equals: 2.
	self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements second codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements second document equals: aCodeSnippet bindings.
	^ aCodeSnippet
]

{ #category : #'adding non-existent example class' }
GtOldExampleCodeSnippetExamples >> addNonExistentExampleMethod [
	<gtExample>
	<label: 'Add non-existent example method'>
	| aCodeSnippet anAnnouncements |
	aCodeSnippet := self codeSnippetOfDocumentWithNonExistentExampleClass.
	self assert: aCodeSnippet isMethodClassDefined not.
	self assert: aCodeSnippet isMethodDefined not.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtOldDocumenterExamplesUtility 
		createClassNamed: aCodeSnippet methodClassName 
		during: [ :theClass | 
			self assert: anAnnouncements size equals: 1.
			theClass compile: aCodeSnippet methodSelectorName classified: 'example'.
			self assert: anAnnouncements size equals: 2.
			self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
			self assert: anAnnouncements first document equals: aCodeSnippet bindings.
			self assert: aCodeSnippet isMethodClassDefined.
			self assert: aCodeSnippet isMethodDefined ].
	self assert: anAnnouncements size equals: 3.
	self assert: anAnnouncements third class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements third codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements third document equals: aCodeSnippet bindings.
	^ aCodeSnippet
]

{ #category : #'empty example definition' }
GtOldExampleCodeSnippetExamples >> codeSnippetOfDocumentWithEmptyDefinition [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with empty definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithEmptyDefinition.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'example with empty show definition' }
GtOldExampleCodeSnippetExamples >> codeSnippetOfDocumentWithEmptyShowParameter [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with an empty show parameter'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithEmptyShowParameter.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet'.
	self assert: aCodeSnippet showMessageName equals: GtDocumenterConstants defaultShowMethodName.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'example with expanded preview' }
GtOldExampleCodeSnippetExamples >> codeSnippetOfDocumentWithExpandedPreview [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with expanded preview'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithExpandedPreview.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet'.
	self assert: aCodeSnippet showMessageName equals: GtDocumenterConstants defaultShowMethodName.
	self assert: aCodeSnippet shouldExpandPreview.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'non-existent example class' }
GtOldExampleCodeSnippetExamples >> codeSnippetOfDocumentWithNonExistentExampleClass [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with non-existent example class'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithNonExistentExampleClass.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtDocumenterNonExistentClass>>#nonExistentMethod'.
	self assert: aCodeSnippet shouldDisplayResult.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet isMethodDefined not.
	self assert: aCodeSnippet isMethodClassDefined not.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'non-existent example method' }
GtOldExampleCodeSnippetExamples >> codeSnippetOfDocumentWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with non-existent example method'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithNonExistentExampleMethod.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#nonExistentMethod'.
	self assert: aCodeSnippet shouldDisplayResult.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet isMethodDefined not.
	self assert: aCodeSnippet isMethodClassDefined.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'simple example definition' }
GtOldExampleCodeSnippetExamples >> codeSnippetOfDocumentWithOneExampleCodeSnippet [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithOneExampleCodeSnippet.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet'.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'partial example definition' }
GtOldExampleCodeSnippetExamples >> codeSnippetOfDocumentWithPartialDefinition [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with partial definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithPartialDefinition.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtExampleCodeSnippetExamples>>#'''''.
	self assert: aCodeSnippet shouldDisplayResult.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet isMethodDefined not.
	self assert: aCodeSnippet isMethodClassDefined.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'empty example definition' }
GtOldExampleCodeSnippetExamples >> documentWithEmptyDefinition [
	<gtExample>
	<label: 'Document with an example code snippet with empty definition'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithEmptyDefinition.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldDefaultCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'example with empty show definition' }
GtOldExampleCodeSnippetExamples >> documentWithEmptyShowParameter [
	<gtExample>
	<label: 'Document with an example code snippet with an empty show parameter'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithEmptyShowParameter.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'example with expanded preview' }
GtOldExampleCodeSnippetExamples >> documentWithExpandedPreview [
	<gtExample>
	<label: 'Document with an example code snippet with expanded preview'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithExpandedPreview.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'non-existent example class' }
GtOldExampleCodeSnippetExamples >> documentWithNonExistentExampleClass [
	<gtExample>
	<label: 'Document with an example code snippet with non-existent example class'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithNonExistentExampleClass.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'non-existent example method' }
GtOldExampleCodeSnippetExamples >> documentWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Document with an example code snippet with non-existent example method'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithNonExistentExampleMethod.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'simple example definition' }
GtOldExampleCodeSnippetExamples >> documentWithOneExampleCodeSnippet [
	<gtExample>
	<label: 'Document with an example code snippet'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithOneExampleCodeSnippet.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'partial example definition' }
GtOldExampleCodeSnippetExamples >> documentWithPartialDefinition [
	<gtExample>
	<label: 'Document with an example code snippet with partial definition'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithPartialDefinition.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'empty example definition' }
GtOldExampleCodeSnippetExamples >> fileReferenceWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with empty definition'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithEmptyDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'example with empty show definition' }
GtOldExampleCodeSnippetExamples >> fileReferenceWithEmptyShowParameter [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with an empty show parameter'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithEmptyShowParameter.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'example with expanded preview' }
GtOldExampleCodeSnippetExamples >> fileReferenceWithExpandedPreview [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with expanded preview'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExpandedPreview.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'non-existent example class' }
GtOldExampleCodeSnippetExamples >> fileReferenceWithNonExistentExampleClass [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with non-existent example class'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistentExampleClass.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'non-existent example method' }
GtOldExampleCodeSnippetExamples >> fileReferenceWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with non-existent example method'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistentExampleMethod.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'simple example definition' }
GtOldExampleCodeSnippetExamples >> fileReferenceWithOneExampleCodeSnippet [
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
GtOldExampleCodeSnippetExamples >> fileReferenceWithPartialDefinition [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with partial definition'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithPartialDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'empty example definition' }
GtOldExampleCodeSnippetExamples >> pillarContentWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar content with empty definition'>
	^ '
[[[example=]]]
'

]

{ #category : #'example with empty show definition' }
GtOldExampleCodeSnippetExamples >> pillarContentWithEmptyShowParameter [
	<gtExample>
	<label: 'Pillar content with an example code snippet with an empty show parameter'>
	^ '
[[[example=GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet|show=]]]
'

]

{ #category : #'example with expanded preview' }
GtOldExampleCodeSnippetExamples >> pillarContentWithExpandedPreview [
	<gtExample>
	<label: 'Pillar content with an example code snippet with expanded preview'>
	^ '
[[[example=GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet|expandedPreview=]]]
'

]

{ #category : #'non-existent example class' }
GtOldExampleCodeSnippetExamples >> pillarContentWithNonExistentExampleClass [
	<gtExample>
	<label: 'Pillar content with non-existent example class'>
	^ '
[[[example=GtDocumenterNonExistentClass>>#nonExistentMethod]]]
'

]

{ #category : #'non-existent example method' }
GtOldExampleCodeSnippetExamples >> pillarContentWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Pillar content with non-existent example method'>
	^ '
[[[example=GtExampleCodeSnippetExamples>>#nonExistentMethod]]]
'

]

{ #category : #'simple example definition' }
GtOldExampleCodeSnippetExamples >> pillarContentWithOneExampleCodeSnippet [
	<gtExample>
	<label: 'Pillar content with an example code snippet'>
	^ '
[[[example=GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet]]]
'

]

{ #category : #'partial example definition' }
GtOldExampleCodeSnippetExamples >> pillarContentWithPartialDefinition [
	<gtExample>
	<label: 'Pillar content with partial definition'>
	^ '
[[[example=GtExampleCodeSnippetExamples]]]
'

]

{ #category : #'empty example definition' }
GtOldExampleCodeSnippetExamples >> pillarElementWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar element with an example code snippet with empty definition'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'example with empty show definition' }
GtOldExampleCodeSnippetExamples >> pillarElementWithEmptyShowParameter [
	<gtExample>
	<label: 'Pillar element with an example code snippet with an empty show parameter'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithEmptyShowParameter.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'example with expanded preview' }
GtOldExampleCodeSnippetExamples >> pillarElementWithExpandedPreview [
	<gtExample>
	<label: 'Pillar element with an example code snippet with expanded preview'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithExpandedPreview.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'non-existent example class' }
GtOldExampleCodeSnippetExamples >> pillarElementWithNonExistentExampleClass [
	<gtExample>
	<label: 'Pillar element with an example code snippet with non-existent example class'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithNonExistentExampleClass.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'non-existent example method' }
GtOldExampleCodeSnippetExamples >> pillarElementWithNonExistentExampleMethod [
	<gtExample>
	<label: 'Pillar element with an example code snippet with non-existent example method'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithNonExistentExampleMethod.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'simple example definition' }
GtOldExampleCodeSnippetExamples >> pillarElementWithOneExampleCodeSnippet [
	<gtExample>
	<label: 'Pillar element with an example code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithOneExampleCodeSnippet.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	^ pillarElement
]

{ #category : #'partial example definition' }
GtOldExampleCodeSnippetExamples >> pillarElementWithPartialDefinition [
	<gtExample>
	<label: 'Pillar element with an example code snippet with partial definition'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithPartialDefinition.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement
]
