Extension { #name : #PRListItem }

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
