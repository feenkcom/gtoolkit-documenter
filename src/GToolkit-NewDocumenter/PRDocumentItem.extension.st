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

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtSubscriber [
	<return: #Object>
	^ self propertyAt: #gtSubscriber
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtSubscriber: anObject [
	self propertyAt: #gtSubscriber put: anObject
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> styleInText: aBlRope [ 
	"Subclasses can add more styling"
	(aBlRope 
			from: self start 
			to: self stop)
				underlinePaint: Gt2DocumentConstants linkWithErrorColor
]
