Extension { #name : #PRDocumentItem }

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> constants [
	^ Gt2DocumentConstants
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> cursorLeftInText: aBlRopedText [ 
	"Subclasses can add behavior"
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> cursorNearbyInText: aBlRope [
	"Subclasses can update it"
]

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
PRDocumentItem >> gtListItemStyler [
	<return: #Gt2ListItemStyler>
	^ self propertyAt: #gtListItemStyler
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> gtListItemStyler: aGt2ListItemStyler [
	self propertyAt: #gtListItemStyler put: aGt2ListItemStyler
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
PRDocumentItem >> styleText: aBlRope [ 
	"I will be replaced by styleTextWithMarkup: and styleTextWithoutMarkup:"
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> styleText: aBlRope using: aGt2StylerStrategy [
	aGt2StylerStrategy styleText: aBlRope withNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> styleTextWithMarkup: aBlRope [
	"Subclasses can add text styling for Documenter editing mode"
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> styleTextWithoutMarkup: aBlRope [ 
	"Subclasses can add text styling for Documenter reading mode"
]

{ #category : #'*GToolkit-NewDocumenter' }
PRDocumentItem >> utility [
	^ Gt2DocumentUtility
]
