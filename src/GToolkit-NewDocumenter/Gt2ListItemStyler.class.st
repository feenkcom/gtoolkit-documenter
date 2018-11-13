Class {
	#name : #Gt2ListItemStyler,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #accessing }
Gt2ListItemStyler >> style: aBlRope at: aPRListItem [ 
	self subclassResponsibility
]
