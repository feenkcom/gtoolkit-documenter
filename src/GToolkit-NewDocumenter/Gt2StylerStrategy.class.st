Class {
	#name : #Gt2StylerStrategy,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #'instance creation' }
Gt2StylerStrategy class >> editingMode [
	^ Gt2EditingModeStrategy uniqueInstance
]

{ #category : #'instance creation' }
Gt2StylerStrategy class >> readingMode [
	^ Gt2ReadingModeStrategy uniqueInstance
]

{ #category : #dispatch }
Gt2StylerStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	self subclassResponsibility
]
