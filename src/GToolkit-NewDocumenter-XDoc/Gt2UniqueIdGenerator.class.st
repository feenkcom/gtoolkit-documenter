Class {
	#name : #Gt2UniqueIdGenerator,
	#superclass : #Object,
	#instVars : [
		'counter'
	],
	#category : #'GToolkit-NewDocumenter-XDoc-Utility'
}

{ #category : #initialization }
Gt2UniqueIdGenerator >> initialize [
	super initialize.
	counter := 0.
]

{ #category : #accessing }
Gt2UniqueIdGenerator >> next [
	<return: #Integer>
	counter := counter + 1.
	^ counter
]
