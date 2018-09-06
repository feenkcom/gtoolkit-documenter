Extension { #name : #PRPillarParser }

{ #category : #'*GToolkit-Documenter' }
PRPillarParser >> sourceFile [
	self flag: 'Is this a part of an obsolete API?'.
	^ self 
		propertyAt: #sourceFile 
		ifAbsent: [ self error: 'Source file should be initialized first' ]
]

{ #category : #'*GToolkit-Documenter' }
PRPillarParser >> sourceFile: aFileReference [
	self flag: 'Is this a part of an obsolete API?'.
	self 
		assert: [ aFileReference notNil ] 
		description: [ 'Source file should be initialized' ].
	self 
		assert: [ aFileReference exists ] 
		description: [ 'Source file should exist' ].
	self propertyAt: #sourceFile put: aFileReference
]
