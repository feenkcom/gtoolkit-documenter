Extension { #name : #PRStrikethroughFormat }

{ #category : #'*GToolkit-Documenter' }
PRStrikethroughFormat >> styleSubText: aBlRope [
	^ aBlRope foreground: self constants subtleColor
]
