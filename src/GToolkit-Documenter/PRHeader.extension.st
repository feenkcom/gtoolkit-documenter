Extension { #name : #PRHeader }

{ #category : #'*GToolkit-Documenter' }
PRHeader >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(aBlRope
		from: self start
		to: self stop)
			bold;
			fontSize: self gtDocument normalFontSize * 3 - (self level * self constants headerLevelStep);
			paragraphMargin: (self constants headerMarginForLevel: self level).
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
