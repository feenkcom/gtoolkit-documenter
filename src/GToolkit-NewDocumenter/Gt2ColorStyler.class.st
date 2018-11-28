Class {
	#name : #Gt2ColorStyler,
	#superclass : #Gt2ListItemStyler,
	#instVars : [
		'colorIndex',
		'colors'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #actions }
Gt2ColorStyler >> changeColor [
	colorIndex := (colorIndex = colors size)
		ifTrue: [ 1 ] 
		ifFalse: [ colorIndex + 1 ].
]

{ #category : #accessing }
Gt2ColorStyler >> currentColor [
	^ colors at: colorIndex
]

{ #category : #initialization }
Gt2ColorStyler >> initialize [
	super initialize.
	colors := { Color purple. Color lightOrange. }.
	colorIndex := 1.
]

{ #category : #actions }
Gt2ColorStyler >> styleTextWithMarkup: aBlRope forNode: aPRListItem [ 
	| aColor |
	aColor := self currentColor.
	(aBlRope
		from: aPRListItem start
		to: aPRListItem start)
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beAppend; 
					stencil: [
						BlElement new
							geometry: BlCircle new;
							size: 5@5;
							background: aColor ] }.
]
