Extension { #name : #PRListItem }

{ #category : #'*GToolkit-Documenter' }
PRListItem >> cursorLeftInText: aBlRope [ 
	self gtListItemStyler cursorLeftInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRListItem >> cursorNearbyInText: aBlRope [
	self gtListItemStyler cursorNearbyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRListItem >> gtListItemIndex [
	<return: #Integer>
	^ self propertyAt: #gtListItemIndex
]

{ #category : #'*GToolkit-Documenter' }
PRListItem >> gtListItemIndex: anInteger [
	self propertyAt: #gtListItemIndex put: anInteger
]

{ #category : #'*GToolkit-Documenter' }
PRListItem >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self gtListItemStyler styleTextWithMarkup: aBlRope forNode: self.
]

{ #category : #'*GToolkit-Documenter' }
PRListItem >> styleTextWithoutMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self gtListItemStyler styleTextWithoutMarkup: aBlRope forNode: self.
]
