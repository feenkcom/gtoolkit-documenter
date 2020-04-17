Class {
	#name : #XdDocumenterShareDialogStencil,
	#superclass : #BrStencil,
	#instVars : [
		'document'
	],
	#category : #'GToolkit-Documenter-XDoc-Stencils'
}

{ #category : #'api - instantiation' }
XdDocumenterShareDialogStencil >> create [
	<return: #Object>
	| anInformation anActions |
	anInformation := XdDocumenterShareInformation default last.
	anActions := XdShareActions new.
	anActions 
		publishAction: [ self document publishXDocWithInformation: anInformation ];
		updateAction: [ self document updateXDocWithInformation: anInformation ];
		deleteAction: [ self document deleteXDocWithInformation: anInformation ].
	^ XdShareDialogElement new  
		look: XdShareDialogLook;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c padding: (BlInsets all: 5).
			c vertical exact: 400.
			c horizontal exact: 400 ];
		information: anInformation;
		actions: anActions.
			
]

{ #category : #accessing }
XdDocumenterShareDialogStencil >> document [
	^ document
]

{ #category : #accessing }
XdDocumenterShareDialogStencil >> document: anObject [
	document := anObject
]
