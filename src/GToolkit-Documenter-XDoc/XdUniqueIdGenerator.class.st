Class {
	#name : #XdUniqueIdGenerator,
	#superclass : #Object,
	#instVars : [
		'counter'
	],
	#category : #'GToolkit-Documenter-XDoc-Utility'
}

{ #category : #initialization }
XdUniqueIdGenerator >> initialize [
	super initialize.
	counter := 0.
]

{ #category : #accessing }
XdUniqueIdGenerator >> next [
	<return: #Integer>
	counter := counter + 1.
	^ counter
]
