Extension { #name : #PRHeader }

{ #category : #'*GToolkit-Documenter' }
PRHeader >> styleTextWithMarkup: aBlRope [
	(aBlRope
		from: self start
		to: self stop)
			fontSize: self constants headerFontSize - (self level * self constants headerLevelStep)";
			paragraphMargin: (BlInsets top: 15 left: 20 bottom: 15 right: 20)".
	super styleTextWithMarkup: aBlRope
]

{ #category : #'*GToolkit-Documenter' }
PRHeader >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithMarkup: aBlRope.
	(self gtNodeStyler: aBlRope)
		if: self level isNumber
			do: [ :aStyler |
				self children isEmpty ifFalse: [
					aStyler 
						autoHideTextFrom: self start 
						to: self children first start - 1 ] ]
]
