Extension { #name : #BlText }

{ #category : #'*GToolkit-Documenter-BrTextPetitParserCompatibility' }
BlText >> asPetitStream [
	^ BrTextPetitStream on: self
]

{ #category : #'*GToolkit-Documenter-BrTextPetitParserCompatibility' }
BlText >> readStream [
	^ self iterator
]

{ #category : #'*GToolkit-Documenter-BrTextPetitParserCompatibility' }
BlText >> trimLeft: aLeftBlock right: aRightBlock [
	"Trim characters satisfying the condition given in aLeftBlock from the left side 
	and aRightBlock from the right sides of the receiving string."

	| left right |
	left := 1.
	right := self size.
	
	[ left <= right and: [ aLeftBlock value: (self at: left) ] ]
		whileTrue: [ left := left + 1 ].
		
	[ left <= right and: [ aRightBlock value: (self at: right) ] ]
		whileTrue: [ right := right - 1 ].
		
	^ self from: left to: right
]

{ #category : #'*GToolkit-Documenter-BrTextPetitParserCompatibility' }
BlText >> trimRight: aBlock [
	"Trim characters satisfying the condition given in aBlock from the right side of the receiving string."

	^ self trimLeft: [ :char | false ] right: aBlock
]

{ #category : #'*GToolkit-Documenter-BrTextPetitParserCompatibility' }
BlText >> withoutTrailingNewlines [
	"Return a copy of the receiver with any combination of cr/lf characters at the end removed"

	^ self trimRight: [ :char | char = Character cr or: [ char = Character lf ] ]
]
