Extension { #name : #PRParagraph }

{ #category : #'*GToolkit-NewDocumenter' }
PRParagraph >> styleTextReadingMode: aBlRope [
	super styleTextReadingMode: aBlRope.
	(aBlRope from: self start to: self stop) attribute: (BrTextCursorAttribute new
		enterAction: [ :aTextEditor |
			self accept: (Gt2CursorNearByVisitor new text: aTextEditor text).
			aTextEditor invalidate: self start to: self stop; update: self start to: self stop ];
		leaveAction: [ :aTextEditor |
			self accept: (Gt2CursorLeftVisitor new text: aTextEditor text).
			aTextEditor invalidate: self start to: self stop; update: self start to: self stop ])
]
