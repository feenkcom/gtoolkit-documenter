Class {
	#name : #Gt2StyleWithoutMarkupStrategy,
	#superclass : #Gt2StylerStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #cleanup }
Gt2StyleWithoutMarkupStrategy class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
Gt2StyleWithoutMarkupStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
Gt2StyleWithoutMarkupStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
Gt2StyleWithoutMarkupStrategy >> isReading [
	^ true
]

{ #category : #dispatch }
Gt2StyleWithoutMarkupStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextWithoutMarkup: aBlRope
]
