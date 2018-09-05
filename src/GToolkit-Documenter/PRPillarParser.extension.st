Extension { #name : #PRPillarParser }

{ #category : #'*GToolkit-Documenter' }
PRPillarParser >> sourceFile: aFileReference [
	self 
		assert: [ aFileReference notNil ] 
		description: [ 'Source file should be initialized' ].
	self 
		assert: [ aFileReference exists ] 
		description: [ 'Source file should exist' ].
	self propertyAt: #sourceFile put: aFileReference
]
