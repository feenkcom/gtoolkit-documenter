Extension { #name : #PRSuperscriptFormat }

{ #category : #'*GToolkit-Documenter' }
PRSuperscriptFormat >> styleSubText: aBlRope [
	^ aBlRope
			foreground: self constants subtleColor;
			fontSize: self constants superscriptFontSize
]
