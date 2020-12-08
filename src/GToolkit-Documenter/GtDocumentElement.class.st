Class {
	#name : #GtDocumentElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'document'
	],
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #testing }
GtDocumentElement class >> isDeprecated [
	^ true
]

{ #category : #accessing }
GtDocumentElement >> document [
	^ document
]

{ #category : #accessing }
GtDocumentElement >> document: aGtDocument [
	| anEditorElement |

	self
		assert: [ document isNil ]
		description: [ 'Document must not be initialized' ].

	document := aGtDocument.
	
	anEditorElement := BrEditor new
		text: document editor text;
		styler: document editor styler;
		editor: document editor;
		look: BrGlamorousRegularEditorLook;
		matchParent;
		constraintsDo: [ :c | c padding: (BlInsets all: 10) ].

	document installCompleterForEditorElement: anEditorElement.
	document addOns shortcuts do: [ :eachShortcut |
		anEditorElement addShortcut: (eachShortcut copy 
			action: [ eachShortcut action cull: anEditorElement ]) ].
		
	self addChild: anEditorElement.

	self look: (BrLayoutResizerLook new
		inherit;
		inherit: anEditorElement)
]

{ #category : #initialization }
GtDocumentElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	self matchParent.
]
