Class {
	#name : #GtDocAbstractExamples,
	#superclass : #Object,
	#traits : 'GtDocumenterConstantsTrait',
	#classTraits : 'GtDocumenterConstantsTrait classTrait',
	#instVars : [
		'fileSystemExamples'
	],
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #initialization }
GtDocAbstractExamples >> initialize [
	super initialize.
	fileSystemExamples := GtFileSystemExamples new.
]
