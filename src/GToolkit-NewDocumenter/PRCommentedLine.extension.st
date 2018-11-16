Extension { #name : #PRCommentedLine }

{ #category : #'*GToolkit-NewDocumenter' }
PRCommentedLine >> styleTextEditingMode: aBlRope [
	super styleTextEditingMode: aBlRope.
	(aBlRope
		from: self start
		to: self stop)
			foreground: self constants subtleColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCommentedLine >> styleTextReadingMode: aBlRope [
	self styleTextEditingMode: aBlRope
]
