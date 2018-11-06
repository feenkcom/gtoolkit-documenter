Extension { #name : #PRDocumentItem }

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtDocument [
	<return: #Gt2Document>
	^ self propertyAt: #gtDocument
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtDocument: aGt2Document [
	self propertyAt: #gtDocument put: aGt2Document
]
