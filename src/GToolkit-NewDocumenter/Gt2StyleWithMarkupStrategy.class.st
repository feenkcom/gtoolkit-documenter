Class {
	#name : #Gt2StyleWithMarkupStrategy,
	#superclass : #Gt2StylerStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #cleanup }
Gt2StyleWithMarkupStrategy class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
Gt2StyleWithMarkupStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
Gt2StyleWithMarkupStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
Gt2StyleWithMarkupStrategy >> isEditing [
	^ true
]

{ #category : #dispatch }
Gt2StyleWithMarkupStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextWithMarkup: aBlRope
]
