Class {
	#name : #GtPackageCommentStrategy,
	#superclass : #GtStorageStrategy,
	#instVars : [
		'package'
	],
	#category : #'GToolkit-Documenter-Storage'
}

{ #category : #accessing }
GtPackageCommentStrategy >> basename [
	"Return a string representing the document filename"
	<return: #String>
	^ self name, '.', GtFileUtilityConstants pillarExtension
]

{ #category : #accessing }
GtPackageCommentStrategy >> comment [
	<return: #String>
	^ self packageToComment packageManifestOrNil
		ifNil: [ '' ]
		ifNotNil: [ :manifest |
			manifest hasComment 
				ifTrue: [ manifest comment ] 
				ifFalse: [ '' ] ]
]

{ #category : #accessing }
GtPackageCommentStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self packageToComment
]

{ #category : #testing }
GtPackageCommentStrategy >> exists [
	<return: #Boolean>
	^ true
]

{ #category : #accessing }
GtPackageCommentStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ self packageToComment name
]

{ #category : #accessing }
GtPackageCommentStrategy >> packageToComment [
	^ package
]

{ #category : #accessing }
GtPackageCommentStrategy >> packageToComment: anRPackage [
	self 
		assert: [ anRPackage notNil ]
		description: [ 'Package to document must be non-nil' ].
	package := anRPackage
]

{ #category : #actions }
GtPackageCommentStrategy >> read: aGt2Document [
	aGt2Document text: self comment
]

{ #category : #accessing }
GtPackageCommentStrategy >> rootDirectory [
	<return: #FileReference>
	^ FileSystem workingDirectory
]

{ #category : #actions }
GtPackageCommentStrategy >> save: aGt2Document [ 
	self packageToComment packageManifest
		comment: aGt2Document text asString
			stamp: Author changeStamp
]
