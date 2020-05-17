Extension { #name : #PRHeader }

{ #category : #'*GToolkit-Documenter' }
PRHeader >> styleTextWithMarkup: aBlRope [
	(aBlRope
		from: self start
		to: self stop)
			bold;
			fontSize: self constants headerFontSize - (self level * self constants headerLevelStep)";
			paragraphMargin: (BlInsets top: 100 left: 0 bottom: 10 right: 0)".
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
