Class {
	#name : #Gt2ReadingModeStrategy,
	#superclass : #Gt2StylerStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #cleanup }
Gt2ReadingModeStrategy class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
Gt2ReadingModeStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
Gt2ReadingModeStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
Gt2ReadingModeStrategy >> isReading [
	^ true
]

{ #category : #dispatch }
Gt2ReadingModeStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextReadingMode: aBlRope
]
