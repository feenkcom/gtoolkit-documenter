Extension { #name : #PRCommentedLine }

{ #category : #'*GToolkit-NewDocumenter' }
PRCommentedLine >> styleText: aBlRope [
	(aBlRope
		from: self start
		to: self stop)
			foreground: Gt2DocumentConstants subtleColor
]
