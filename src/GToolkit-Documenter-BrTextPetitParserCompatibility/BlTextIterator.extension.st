Extension { #name : #BlTextIterator }

{ #category : #'*GToolkit-Documenter-BrTextPetitParserCompatibility' }
BlTextIterator >> atEnd [
	^ self hasNext not
]

{ #category : #'*GToolkit-Documenter-BrTextPetitParserCompatibility' }
BlTextIterator >> skip: anInteger [ 
	self subclassResponsibility
]

{ #category : #'*GToolkit-Documenter-BrTextPetitParserCompatibility' }
BlTextIterator >> upToEnd [
	<return: #BlText>
	^ self text from: self position to: self text size
]
