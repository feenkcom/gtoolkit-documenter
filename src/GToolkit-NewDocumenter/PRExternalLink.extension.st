Extension { #name : #PRExternalLink }

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> styleInText: aBlRope [
	(aBlRope
		from: self start
		to: self stop)
			foreground: Gt2DocumentConstants linkColor;
			attributes: { 
				BrTextHoverStylableAttribute new 
					attribute: (BlTextUnderlineAttribute new paint: Gt2DocumentConstants linkColor).
				BrTextClickAttribute new 
					action: [ :aText :aTarget :anEditorElement :anEvent | 
						anEvent modifiers isShift ifFalse: [
							WebBrowser openOn: self url ] ]
			 }
]
