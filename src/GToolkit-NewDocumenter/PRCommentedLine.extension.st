Extension { #name : #PRCommentedLine }

{ #category : #'*GToolkit-NewDocumenter' }
PRCommentedLine >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(aBlRope
		from: self start
		to: self stop)
			foreground: self constants subtleColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCommentedLine >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope
]
