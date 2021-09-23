Class {
	#name : 'GtCodeblockPharoVisitor',
	#superclass : 'GtPharoProgramNodeVisitor',
	#instVars : [
		'symbols'
	],
	#category : 'GToolkit-Documenter-Utility'
}

{ #category : 'initialization' }
GtCodeblockPharoVisitor >> initialize [
	super initialize.
	symbols := GtCodeblockSymbols new.
]

{ #category : 'accessing' }
GtCodeblockPharoVisitor >> symbols [
	<return: #GtCodeblockSymbols>
	^ symbols
]

{ #category : 'generated' }
GtCodeblockPharoVisitor >> visitMessage: aMessage [
	symbols addSelector: aMessage selector.
	super visitMessage: aMessage
]

{ #category : 'generated' }
GtCodeblockPharoVisitor >> visitVariable: aVariable [
	symbols addVariable: aVariable name value.
	super visitVariable: aVariable
]
