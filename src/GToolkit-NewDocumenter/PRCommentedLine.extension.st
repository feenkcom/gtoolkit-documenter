Extension { #name : #PRCommentedLine }

{ #category : #'*GToolkit-NewDocumenter' }
PRCommentedLine >> styleInText: aBlRope [
	(aBlRope
		from: self start
		to: self stop)
			foreground: Gt2DocumentConstants subtleColor
]
