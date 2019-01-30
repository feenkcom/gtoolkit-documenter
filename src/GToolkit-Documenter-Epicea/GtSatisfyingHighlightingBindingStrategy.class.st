Class {
	#name : #GtSatisfyingHighlightingBindingStrategy,
	#superclass : #GtBindingStrategy,
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #private }
GtSatisfyingHighlightingBindingStrategy >> treatBinding: anAssocOrNil of: aSymbol [
	"Subclasses can treat existing or missing bindings of a variable named aSymbol"
	<return: #LiteralVariable or: nil>
	^ anAssocOrNil ifNil: [
		 (WorkspaceVariable named: aSymbol) ]
]
