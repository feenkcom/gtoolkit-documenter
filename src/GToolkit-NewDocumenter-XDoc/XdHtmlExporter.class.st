Class {
	#name : #XdHtmlExporter,
	#superclass : #Object,
	#category : #'GToolkit-NewDocumenter-XDoc-Exporter'
}

{ #category : #testing }
XdHtmlExporter class >> isAbstract [
	^ self name = #OldXdHtmlExporter
]

{ #category : #actions }
XdHtmlExporter >> export: aStream [
	"Export a root source file to an HTML format"
	self subclassResponsibility
]
