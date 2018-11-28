Extension { #name : #PRListItem }

{ #category : #'*GToolkit-NewDocumenter' }
PRListItem >> cursorLeftInText: aBlRope [ 
	self gtListItemStyler cursorLeftInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRListItem >> cursorNearbyInText: aBlRope [
	self gtListItemStyler cursorNearbyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRListItem >> gtListItemIndex [
	<return: #Integer>
	^ self propertyAt: #gtListItemIndex
]

{ #category : #'*GToolkit-NewDocumenter' }
PRListItem >> gtListItemIndex: anInteger [
	self propertyAt: #gtListItemIndex put: anInteger
]

{ #category : #'*GToolkit-NewDocumenter' }
PRListItem >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self gtListItemStyler styleTextWithMarkup: aBlRope forNode: self.
]

{ #category : #'*GToolkit-NewDocumenter' }
PRListItem >> styleTextWithoutMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self gtListItemStyler styleTextWithoutMarkup: aBlRope forNode: self.
]
