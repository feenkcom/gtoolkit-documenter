Extension { #name : #PRStrikethroughFormat }

{ #category : #'*GToolkit-NewDocumenter' }
PRStrikethroughFormat >> styleSubText: aBlRope [
	^ aBlRope
			foreground: self constants subtleColor
]
