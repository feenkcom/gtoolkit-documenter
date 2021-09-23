Extension { #name : 'PRCommentedLine' }

{ #category : '*GToolkit-Documenter' }
PRCommentedLine >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(aBlRope
		from: self start
		to: self stop)
			foreground: self constants subtleColor
]

{ #category : '*GToolkit-Documenter' }
PRCommentedLine >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope
]
