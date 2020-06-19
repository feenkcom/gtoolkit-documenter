Extension { #name : #PREmptyParagraph }

{ #category : #'*GToolkit-Documenter' }
PREmptyParagraph >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(aBlRope
		from: self start
		to: self stop)
			paragraphMargin: self constants paragraphMargin.
]

{ #category : #'*GToolkit-Documenter' }
PREmptyParagraph >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithMarkup: aBlRope.
]
