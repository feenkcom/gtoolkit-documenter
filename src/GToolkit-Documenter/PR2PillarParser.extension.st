Extension { #name : #PR2PillarParser }

{ #category : #'*GToolkit-Documenter' }
PR2PillarParser >> sourceFile [
	^ self 
		propertyAt: #sourceFile 
		ifAbsent: [ self error: 'Source file should be initialized first' ]
]

{ #category : #'*GToolkit-Documenter' }
PR2PillarParser >> sourceFile: aFileReference [
	self 
		assert: [ aFileReference notNil ] 
		description: [ 'Source file should be initialized' ].
	self 
		assert: [ aFileReference exists ] 
		description: [ 'Source file should exist' ].
	self propertyAt: #sourceFile put: aFileReference
]
