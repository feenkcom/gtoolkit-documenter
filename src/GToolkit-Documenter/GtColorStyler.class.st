Class {
	#name : #GtColorStyler,
	#superclass : #GtListItemStyler,
	#instVars : [
		'colorIndex',
		'colors'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #actions }
GtColorStyler >> changeColor [
	colorIndex := (colorIndex = colors size)
		ifTrue: [ 1 ] 
		ifFalse: [ colorIndex + 1 ].
]

{ #category : #accessing }
GtColorStyler >> currentColor [
	^ colors at: colorIndex
]

{ #category : #initialization }
GtColorStyler >> initialize [
	super initialize.
	colors := { Color purple. Color lightOrange. }.
	colorIndex := 1.
]

{ #category : #actions }
GtColorStyler >> styleTextWithMarkup: aBlRope forNode: aPRListItem [ 
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
