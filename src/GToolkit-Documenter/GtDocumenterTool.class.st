Class {
	#name : #GtDocumenterTool,
	#superclass : #GtPhlowTool,
	#instVars : [
		'valuable'
	],
	#category : #'GToolkit-Documenter-Phlow tools'
}

{ #category : #'instance creation' }
GtDocumenterTool class >> forClass: aClass [
	^ self new valuable: [ GtDocumenter forClass: aClass ]
]

{ #category : #'instance creation' }
GtDocumenterTool class >> forFile: aFileReference [
	^ self new valuable: [ GtDocumenter forFile: aFileReference ]
]

{ #category : #'api - converting' }
GtDocumenterTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	^ aOneArgBlock cull: self valuable value
]

{ #category : #defaults }
GtDocumenterTool >> defaultValuable [
	^ [ GtDocumenter new ]
]

{ #category : #initialization }
GtDocumenterTool >> initialize [
	super initialize.
	valuable := self defaultValuable.
]

{ #category : #'api - accessing' }
GtDocumenterTool >> name [
	^ 'documenter'
]

{ #category : #'api - accessing' }
GtDocumenterTool >> valuable [
	^ valuable
]

{ #category : #'api - accessing' }
GtDocumenterTool >> valuable: aValuable [
	self 
		assert: [ aValuable isNotNil ] 
		description: [ 'Documenter tool valuable must be non-nil' ].
	valuable := aValuable
]
