Class {
	#name : #GtDocCodeblockExamples,
	#superclass : #GtDocAbstractExamples,
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #'failed executable code snippet' }
GtDocCodeblockExamples >> codeSnippetOfDocumentWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aDocumentPart anAnnouncements |
	aDocument := self documentWithFailedExecutableCodeSnippet.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self assert: aDocumentPart label equals: 'Compute'.
	anAnnouncements := OrderedCollection new.
	aDocumentPart announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aDocumentPart executeWithPlaygroundStrategy.
	self assert: aDocumentPart hasResult.
	self assert: aDocumentPart result notNil.
	self assert: aDocumentPart result class equals: ZeroDivide.
	self assert: aDocumentPart isException.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetFailedExecutionAnnouncement.
	self assert: anAnnouncements first exception class equals: ZeroDivide.
	self assert: anAnnouncements first codeSnippet equals: aDocumentPart.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first
]

{ #category : #'executable code snippet' }
GtDocCodeblockExamples >> codeSnippetOfDocumentWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithOneExecutableCodeSnippet.
	aCodeSnippet := aDocument documentParts documentPartAt: 1.
	self assert: aCodeSnippet label equals: 'Evaluate'.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aCodeSnippet executeWithPlaygroundStrategy.
	self assert: aCodeSnippet hasResult.
	self assert: aCodeSnippet result notNil.
	self assert: aCodeSnippet result equals: 24.
	self assert: aCodeSnippet isException not.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetSuccessfulExecutionAnnouncement.
	self assert: anAnnouncements first newValue equals: 24.
	self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first
]

{ #category : #'self reference' }
GtDocCodeblockExamples >> codeSnippetOfDocumentWithSelfReference [
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithSelfReference.
	aCodeSnippet := aDocument documentParts documentPartAt: 1.
	self assert: aCodeSnippet label equals: 'Execute'.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aCodeSnippet executeWithPlaygroundStrategy.
	self assert: aCodeSnippet hasResult.
	self assert: aCodeSnippet result notNil.
	self assert: aCodeSnippet result equals: aDocument.
	self assert: aCodeSnippet isException not.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetSuccessfulExecutionAnnouncement.
	self assert: anAnnouncements first newValue equals: aDocument.
	self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first
]

{ #category : #'another language' }
GtDocCodeblockExamples >> documentWithBash [
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aTextElement aDocument codeSnippet |
	aTextElement := self textElementWithBash.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	codeSnippet := aDocument documentParts documentPartAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtPillarCodeblock.
	self 
		assert: codeSnippet pillarNode language
		equals: PRBashScriptLanguage default.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'failed executable code snippet' }
GtDocCodeblockExamples >> documentWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aTextElement aDocument codeSnippet |
	aTextElement := self textElementWithFailedExecutableCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	codeSnippet := aDocument documentParts documentPartAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtPillarCodeblock.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'executable code snippet' }
GtDocCodeblockExamples >> documentWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aTextElement aDocument aDocumentPart |
	aTextElement := self textElementWithOneExecutableCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarCodeblock.
	self assert: aDocumentPart result isNil.
	^ aDocument
]

{ #category : #'self reference' }
GtDocCodeblockExamples >> documentWithSelfReference [
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aTextElement aDocument codeSnippet |
	aTextElement := self textElementWithSelfReference.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	codeSnippet := aDocument documentParts documentPartAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtPillarCodeblock.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #document }
GtDocCodeblockExamples >> documentWithSevenExecutableCodeSnippets [
	<gtExample>
	<label: 'Pillar document with Script executor'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithSevenExecutableCodeSnippets.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'another language' }
GtDocCodeblockExamples >> fileReferenceWithBash [
	<gtExample>
	<label: 'Pillar file reference with an executable code snippet'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithBash.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'failed executable code snippet' }
GtDocCodeblockExamples >> fileReferenceWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar file reference with an executable code snippet'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithFailedExecutableCodeSnippet.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'executable code snippet' }
GtDocCodeblockExamples >> fileReferenceWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar file reference with an executable code snippet'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithOneExecutableCodeSnippet.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'self reference' }
GtDocCodeblockExamples >> fileReferenceWithSelfReference [
	<gtExample>
	<label: 'Pillar file reference with an executable code snippet'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithSelfReference.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> insertMiddlePosition [
	<gtExample>
	<label: 'Inserting position'>
	^ 55
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> insertScriptInTheMiddle [
	<gtExample>
	<label: 'Text editor'>
	| editor twoCodes threeCodes |
	editor := self textEditorWithTwoCodeSnippets.
	twoCodes := GtDocumenterExamplesUtility arrayOfDocumentPartsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: twoCodes size equals: 2.
	editor text insertString: self insertedScript at: self insertMiddlePosition.
	editor styleText.
	threeCodes := GtDocumenterExamplesUtility arrayOfDocumentPartsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 3.
	self assert: threeCodes size equals: 3.
	self assert: twoCodes first == threeCodes first.
	self assert: (twoCodes second == threeCodes second) not.
	self assert: twoCodes second == threeCodes third.
	^ editor
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> insertThreeBracketsInTheMiddle [
	<gtExample>
	<label: 'Text editor'>
	| editor originalCodes newCodes |
	editor := self textEditorWithTwoCodeSnippets.
	originalCodes := GtDocumenterExamplesUtility arrayOfDocumentPartsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: originalCodes size equals: 2.
	editor text insertString: self insertedThreeBrackets at: self insertMiddlePosition.
	editor styleText.
	newCodes := GtDocumenterExamplesUtility arrayOfDocumentPartsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: newCodes size equals: 2.
	self assert: originalCodes first == newCodes first.
	self assert: originalCodes second == newCodes second.
	^ editor
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> insertedScript [
	<gtExample>
	^ '
Inserted script:

[[[
"Inserted"
out + 21
]]]

'
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> insertedThreeBrackets [
	<gtExample>
	^ '
Inserted script:

[[[
"Inserted"

'
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> pillarContentAddingAndRemovingCodeSnippets [
	<gtExample>
	<label: 'Pillar content for testing adding and removing code snippets'>
	^ '! Inserting scripts

[[[label=Sum up
"First"
3 + 7
]]]

[[[label=Print
"Second"
Transcript show: out + 11; cr.
]]]
'

]

{ #category : #'another language' }
GtDocCodeblockExamples >> pillarContentWithBash [
	<gtExample>
	<label: 'Pillar content with an executable code snippet'>
	^ '
[[[language=bash
ls -la "$PWD"
]]]
'

]

{ #category : #'failed executable code snippet' }
GtDocCodeblockExamples >> pillarContentWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar content with an executable code snippet'>
	^ '
[[[label=Compute
1/0.
]]]
'

]

{ #category : #'executable code snippet' }
GtDocCodeblockExamples >> pillarContentWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar content with an executable code snippet'>
	^ '
[[[label=Evaluate
4 factorial.
]]]
'

]

{ #category : #'self reference' }
GtDocCodeblockExamples >> pillarContentWithSelfReference [
	<gtExample>
	<label: 'Pillar content with an executable code snippet'>
	^ '
[[[label=Execute
self.
]]]
'

]

{ #category : #document }
GtDocCodeblockExamples >> pillarContentWithSevenExecutableCodeSnippets [
	<gtExample>
	<label: 'Pillar content with Epicea link'>
	^ '! This is en example of build-in executable code snippets

The first example opens a transcript:

[[[
Transcript open.
]]]

The second example writes to the transcript. Notice that ==variableTwo== is not initialized.

[[[label=Print
variableOne := 42.
Transcript show: ''variableOne = ''; show: variableOne; cr.
Transcript show: ''variableTwo = ''; show: variableTwo; cr.
]]]

In the following script, we assign a value to ==variableTwo==. Notice that ==variableOne== have the same value as above as variableas are shared among the code snippets of the same document.

[[[label=Print
variableTwo := 72.
Transcript show: ''variableOne = ''; show: variableOne; cr.
Transcript show: ''variableTwo = ''; show: variableTwo; cr.
Transcript show: ''variableThree = ''; show: variableThree; cr.
]]]

Now, let''s compute a factorial:

[[[label=Compute
4 factorial.
]]]

And let''s reference the result of the previous script here:

[[[label=Compute
out + 4.
]]]

==out== explicitly reference to a result of the previous code snippet. We can therefore print the previous result:

[[[label=Print
Transcript show: ''4 factorial + 4 = ''; show: out.
]]]

We can reference any code snippet result as presented in the following example:

[[[label=Close Transcript
(outs at: 1) delete.
]]]

'

]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> removeScriptInTheMiddle [
	<gtExample>
	<label: 'Remove a script in the middle'>
	| editor twoCodes threeCodes |
	editor := self insertScriptInTheMiddle.
	threeCodes := GtDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 3.
	self assert: threeCodes size equals: 3.
	editor text
		delete: self insertMiddlePosition
		to: self insertedScript size + self insertMiddlePosition.
	editor styleText.
	twoCodes := GtDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: twoCodes size equals: 2.
	self assert: twoCodes first == threeCodes first.
	self assert: (twoCodes second == threeCodes second) not.
	self assert: twoCodes second == threeCodes third.
	^ editor
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> rootDocumentForAddingAndRemovingCodeSnippets [
	<gtExample>
	<label: 'Pillar document with Script executors'>
	^ fileSystemExamples addPillarFileWithContent: self pillarContentAddingAndRemovingCodeSnippets
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> textEditorWithTwoCodeSnippets [
	<gtExample>
	<label: 'Text editor'>
	| aBrEditorElement editor |
	aBrEditorElement := self textElementWithTwoCodeSnippets.
	editor := aBrEditorElement editor.
	self assert: editor notNil.
	self assert: editor styler document notNil.
	self assert: editor styler document documentParts size equals: 2.
	^ editor
]

{ #category : #'another language' }
GtDocCodeblockExamples >> textElementWithBash [
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithBash.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'failed executable code snippet' }
GtDocCodeblockExamples >> textElementWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithFailedExecutableCodeSnippet.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'executable code snippet' }
GtDocCodeblockExamples >> textElementWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithOneExecutableCodeSnippet.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'self reference' }
GtDocCodeblockExamples >> textElementWithSelfReference [
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithSelfReference.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'editing live document' }
GtDocCodeblockExamples >> textElementWithTwoCodeSnippets [
	<gtExample>
	<label: 'Pillar Bloc element'>
	| aFileReference aTextElement aDocument |
	aFileReference := self rootDocumentForAddingAndRemovingCodeSnippets.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 2.
	^ aTextElement
]
