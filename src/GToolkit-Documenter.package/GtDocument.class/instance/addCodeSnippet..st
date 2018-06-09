as yet unclassified
addCodeSnippet: aGtPillarDocumentExecutablePart 
	documentParts 
		insertScript: aGtPillarDocumentExecutablePart 
		at: aGtPillarDocumentExecutablePart index.
	"aGtPillarDocumentExecutablePart index + 1 to: documentParts size do: [ :anIndex | 
		(documentParts codeSnippetAt: anIndex) index: anIndex ]."