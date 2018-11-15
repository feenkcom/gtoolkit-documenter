Class {
	#name : #Gt2EditingModeStrategy,
	#superclass : #Gt2StylerStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #cleanup }
Gt2EditingModeStrategy class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
Gt2EditingModeStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
Gt2EditingModeStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
Gt2EditingModeStrategy >> isEditing [
	^ true
]

{ #category : #dispatch }
Gt2EditingModeStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextEditingMode: aBlRope
]
