Class {
	#name : #Gt2CodeblockPharoVisitor,
	#superclass : #GtPharoProgramNodeVisitor,
	#instVars : [
		'symbols'
	],
	#category : #'GToolkit-NewDocumenter-Utility'
}

{ #category : #initialization }
Gt2CodeblockPharoVisitor >> initialize [
	super initialize.
	symbols := Gt2CodeblockSymbols new.
]

{ #category : #accessing }
Gt2CodeblockPharoVisitor >> symbols [
	<return: #Gt2CodeblockSymbols>
	^ symbols
]

{ #category : #generated }
Gt2CodeblockPharoVisitor >> visitMessage: aMessage [
	symbols addSelector: aMessage selector.
	super visitMessage: aMessage
]

{ #category : #generated }
Gt2CodeblockPharoVisitor >> visitVariable: aVariable [
	symbols addVariable: aVariable name value.
	super visitVariable: aVariable
]
