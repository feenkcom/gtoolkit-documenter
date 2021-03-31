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
	^ self new valuable: [ (GtDocumenter forClass: aClass) 
		withDefaultToolbar;
		asPagerPageElement ]
]

{ #category : #'instance creation' }
GtDocumenterTool class >> forFile: aFileReference [
	^ self new valuable: [ (GtDocumenter forFile: aFileReference) 
		withDefaultToolbar;
		asPagerPageElement ]
]

{ #category : #'api - converting' }
GtDocumenterTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block."
	^ aOneArgBlock cull: self valuable value
]

{ #category : #defaults }
GtDocumenterTool >> defaultValuable [
	^ [ GtDocumenter new asPagerPageElement ]
]

{ #category : #'api - converting' }
GtDocumenterTool >> icon [
	^ BrGlamorousIcons file
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

{ #category : #'private - accessing' }
GtDocumenterTool >> tabLook [
	^ BrGlamorousTabSwitcherWithIconAptitude
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
