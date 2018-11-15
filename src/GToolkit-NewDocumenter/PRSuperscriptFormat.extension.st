Extension { #name : #PRSuperscriptFormat }

{ #category : #'*GToolkit-NewDocumenter' }
PRSuperscriptFormat >> styleSubText: aBlRope [
	^ aBlRope
			foreground: self constants subtleColor;
			fontSize: self constants superscriptFontSize
]
