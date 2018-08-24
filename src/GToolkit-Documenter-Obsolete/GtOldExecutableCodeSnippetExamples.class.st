"
! Executable Pillar Scripts

!! Initial Example 

To experiment in this tutorial, first open a trascript:

[[[label=Open Transcript
Transcript open.
]]]

The following Pillar document includes two code snippets that we will use for experimenting:

[[[example=GtExecutableCodeSnippetExamples>>#pillarElementWithTwoCodeSnippets|noCode|showLive|height=300]]]

First, evaluate both code snippets. You should obtain a ==21== number in the trascript.

!! Inserting a Code Snippet

Now, try to insert another code snippet with ==out + 21== between two existing code snippets. You should obtain a document like this: 

[[[example=GtExecutableCodeSnippetExamples>>#insertScriptInTheMiddle|noCode|showLive|height=300]]]

You can notice that you do not need evaluate the first code snippet again. You have to evaluate the new one, following by the last one. The obtained value in the transcript should be ==42==.

!! Removing a Code Snippet

Now, try to remove the recently added code snippet. It is enought to remove one ==[== bracket character. If you evaluate the last code snippet, you will obtain again the value =21= in the transcript. Notice that it is not necessary to re-evaluate again the first code snippet. The editor rembers last values whenever possible.
 
"
Class {
	#name : #GtOldExecutableCodeSnippetExamples,
	#superclass : #GtOldDebuggableCodeSnippetExamples,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'failed executable code snippet' }
GtOldExecutableCodeSnippetExamples >> codeSnippetOfDocumentWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithFailedExecutableCodeSnippet.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet label equals: 'Compute'.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aCodeSnippet executeWithPlaygroundStrategy.
	self assert: aCodeSnippet hasResult.
	self assert: aCodeSnippet result notNil.
	self assert: aCodeSnippet value class equals: ZeroDivide.
	self assert: aCodeSnippet isException.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetFailedExecutionAnnouncement.
	self assert: anAnnouncements first exception class equals: ZeroDivide.
	self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first
]

{ #category : #'executable code snippet' }
GtOldExecutableCodeSnippetExamples >> codeSnippetOfDocumentWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithOneExecutableCodeSnippet.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet label equals: 'Evaluate'.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aCodeSnippet executeWithPlaygroundStrategy.
	self assert: aCodeSnippet hasResult.
	self assert: aCodeSnippet result notNil.
	self assert: aCodeSnippet value equals: 24.
	self assert: aCodeSnippet isException not.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetSuccessfulExecutionAnnouncement.
	self assert: anAnnouncements first newValue equals: 24.
	self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first
]

{ #category : #'self reference' }
GtOldExecutableCodeSnippetExamples >> codeSnippetOfDocumentWithSelfReference [
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithSelfReference.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet label equals: 'Execute'.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aCodeSnippet executeWithPlaygroundStrategy.
	self assert: aCodeSnippet hasResult.
	self assert: aCodeSnippet result notNil.
	self assert: aCodeSnippet value equals: aDocument.
	self assert: aCodeSnippet isException not.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetSuccessfulExecutionAnnouncement.
	self assert: anAnnouncements first newValue equals: aDocument.
	self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first
]

{ #category : #'failed executable code snippet' }
GtOldExecutableCodeSnippetExamples >> documentWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithFailedExecutableCodeSnippet.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExecutableCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'executable code snippet' }
GtOldExecutableCodeSnippetExamples >> documentWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithOneExecutableCodeSnippet.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExecutableCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'self reference' }
GtOldExecutableCodeSnippetExamples >> documentWithSelfReference [
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithSelfReference.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldExecutableCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #document }
GtOldExecutableCodeSnippetExamples >> documentWithSevenExecutableCodeSnippets [
	<gtExample>
	<label: 'Pillar document with Script executor'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithSevenExecutableCodeSnippets.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'failed executable code snippet' }
GtOldExecutableCodeSnippetExamples >> fileReferenceWithFailedExecutableCodeSnippet [
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
GtOldExecutableCodeSnippetExamples >> fileReferenceWithOneExecutableCodeSnippet [
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
GtOldExecutableCodeSnippetExamples >> fileReferenceWithSelfReference [
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
GtOldExecutableCodeSnippetExamples >> insertMiddlePosition [
	<gtExample>
	<label: 'Inserting position'>
	^ 55
]

{ #category : #'editing live document' }
GtOldExecutableCodeSnippetExamples >> insertScriptInTheMiddle [
	<gtExample>
	<label: 'Text editor'>
	| editor twoCodes threeCodes |
	editor := self textEditorWithTwoCodeSnippets.
	twoCodes := GtOldDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtOldDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: twoCodes size equals: 2.
	editor text insertString: self insertedScript at: self insertMiddlePosition.
	editor styleText.
	threeCodes := GtOldDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtOldDocumenterExamplesUtility outsFromEditor: editor) size equals: 3.
	self assert: threeCodes size equals: 3.
	self assert: twoCodes first == threeCodes first.
	self assert: (twoCodes second == threeCodes second) not.
	self assert: twoCodes second == threeCodes third.
	^ editor
]

{ #category : #'editing live document' }
GtOldExecutableCodeSnippetExamples >> insertThreeBracketsInTheMiddle [
	<gtExample>
	<label: 'Text editor'>
	| editor originalCodes newCodes |
	editor := self textEditorWithTwoCodeSnippets.
	originalCodes := GtOldDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtOldDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: originalCodes size equals: 2.
	editor text insertString: self insertedThreeBrackets at: self insertMiddlePosition.
	editor styleText.
	newCodes := GtOldDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtOldDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: newCodes size equals: 2.
	self assert: originalCodes first == newCodes first.
	self assert: originalCodes second == newCodes second.
	^ editor
]

{ #category : #'editing live document' }
GtOldExecutableCodeSnippetExamples >> insertedScript [
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
GtOldExecutableCodeSnippetExamples >> insertedThreeBrackets [
	<gtExample>
	^ '
Inserted script:

[[[
"Inserted"

'
]

{ #category : #'editing live document' }
GtOldExecutableCodeSnippetExamples >> pillarContentAddingAndRemovingCodeSnippets [
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

{ #category : #'failed executable code snippet' }
GtOldExecutableCodeSnippetExamples >> pillarContentWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar content with an executable code snippet'>
	^ '
[[[label=Compute
1/0.
]]]
'

]

{ #category : #'executable code snippet' }
GtOldExecutableCodeSnippetExamples >> pillarContentWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar content with an executable code snippet'>
	^ '
[[[label=Evaluate
4 factorial.
]]]
'

]

{ #category : #'self reference' }
GtOldExecutableCodeSnippetExamples >> pillarContentWithSelfReference [
	<gtExample>
	<label: 'Pillar content with an executable code snippet'>
	^ '
[[[label=Execute
self.
]]]
'

]

{ #category : #document }
GtOldExecutableCodeSnippetExamples >> pillarContentWithSevenExecutableCodeSnippets [
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

{ #category : #'failed executable code snippet' }
GtOldExecutableCodeSnippetExamples >> pillarElementWithFailedExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithFailedExecutableCodeSnippet.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'executable code snippet' }
GtOldExecutableCodeSnippetExamples >> pillarElementWithOneExecutableCodeSnippet [
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithOneExecutableCodeSnippet.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'self reference' }
GtOldExecutableCodeSnippetExamples >> pillarElementWithSelfReference [
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithSelfReference.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'editing live document' }
GtOldExecutableCodeSnippetExamples >> pillarElementWithTwoCodeSnippets [
	<gtExample>
	<label: 'Pillar Bloc element'>
	| rootDocument pillarElement |
	rootDocument := self rootDocumentForAddingAndRemovingCodeSnippets.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: rootDocument.
	self assert: pillarElement document outs size equals: 2.
	^ pillarElement
]

{ #category : #'editing live document' }
GtOldExecutableCodeSnippetExamples >> removeScriptInTheMiddle [
	<gtExample>
	<label: 'Remove a script in the middle'>
	| editor twoCodes threeCodes |
	editor := self insertScriptInTheMiddle.
	threeCodes := GtOldDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtOldDocumenterExamplesUtility outsFromEditor: editor) size equals: 3.
	self assert: threeCodes size equals: 3.
	editor text
		delete: self insertMiddlePosition
		to: self insertedScript size + self insertMiddlePosition.
	editor styleText.
	twoCodes := GtOldDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtOldDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: twoCodes size equals: 2.
	self assert: twoCodes first == threeCodes first.
	self assert: (twoCodes second == threeCodes second) not.
	self assert: twoCodes second == threeCodes third.
	^ editor
]

{ #category : #'editing live document' }
GtOldExecutableCodeSnippetExamples >> rootDocumentForAddingAndRemovingCodeSnippets [
	<gtExample>
	<label: 'Pillar document with Script executors'>
	^ fileSystemExamples addPillarFileWithContent: self pillarContentAddingAndRemovingCodeSnippets
]

{ #category : #'editing live document' }
GtOldExecutableCodeSnippetExamples >> textEditorWithTwoCodeSnippets [
	<gtExample>
	<label: 'Text editor'>
	| pillarElement editor |
	pillarElement := self pillarElementWithTwoCodeSnippets.
	editor := pillarElement contentElement editor.
	self assert: editor notNil.
	self assert: editor styler workspace notNil.
	self assert: editor styler workspace outs size equals: 2.
	^ editor
]
