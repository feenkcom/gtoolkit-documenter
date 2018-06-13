utility - accessing
arrayOfDocumentPartsFromEditor: aBrTextEditor 
	<return: #Array of: #GtPillarDocumentPart>
	| outs |
	outs := self outsFromEditor: aBrTextEditor.
	^ Array new: outs size streamContents: [ :aStream | 
		1 to: outs size do: [ :anIndex | | aSnippet |
			aSnippet := outs documentPartAt: anIndex.
			aStream nextPut: aSnippet.
			"self assert: aSnippet index equals: anIndex" ] ]