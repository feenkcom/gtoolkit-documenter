Class {
	#name : #Gt2CounterStyler,
	#superclass : #Gt2ListItemStyler,
	#instVars : [
		'counter'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #initialization }
Gt2CounterStyler >> initialize [
	super initialize.
	counter := 0.
]

{ #category : #accessing }
Gt2CounterStyler >> style: aBlRope at: aPRListItem [ 
	| anItemIndex |
	counter := counter + 1.
	anItemIndex := counter asString.
	(aBlRope
		from: aPRListItem start
		to: aPRListItem start)
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beAppend; 
					stencil: [
						| indexText |
						indexText := anItemIndex asRopedText.
						indexText fontSize: self constants superscriptFontSize.
						indexText foreground: self constants subtleColor.
						BlTextElement new 
							text: indexText; 
							clipChildren: false;
							looseMesurement; 
							ascentBaseline ] }.
]
