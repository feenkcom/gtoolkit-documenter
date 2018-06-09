instance creation
newDocumentPartAtSameIndex
	| aNewDocumentPart |
	aNewDocumentPart := self documentPartClass new.
	aNewDocumentPart 
		pillarNode: self pillarNode;
		document: self document.
	^ aNewDocumentPart