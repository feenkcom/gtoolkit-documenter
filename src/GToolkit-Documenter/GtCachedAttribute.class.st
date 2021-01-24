Class {
	#name : #GtCachedAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'attribute',
		'onCachingAction',
		'cachedElement'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #testing }
GtCachedAttribute class >> isDeprecated [
	^ true
]

{ #category : #accessing }
GtCachedAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ self hasCache 
			ifTrue: [ self cache removeFromParent ]
			ifFalse: [ | anElement |
				anElement := self attribute affect: aTBrTextEditorTextualPiece in: anEditorElement.
				self updateCache: anElement.
				anElement ]
]

{ #category : #accessing }
GtCachedAttribute >> attribute [
	^ attribute
]

{ #category : #accessing }
GtCachedAttribute >> attribute: anObject [
	attribute := anObject
]

{ #category : #accessing }
GtCachedAttribute >> beAppend [
	super beAppend.
	self attribute beAppend.
]

{ #category : #accessing }
GtCachedAttribute >> beReplace [
	super beReplace.
	self attribute beReplace.
]

{ #category : #accessing }
GtCachedAttribute >> cache [
	<return: #BlElement or: nil>
	^ cachedElement
]

{ #category : #accessing }
GtCachedAttribute >> cache: aBlElement [
	cachedElement := aBlElement.
]

{ #category : #testing }
GtCachedAttribute >> hasCache [
	^ self cache notNil
]

{ #category : #initialization }
GtCachedAttribute >> initialize [
	super initialize.
	attribute := GtPreviewAttribute new.
	cachedElement := nil.
	onCachingAction := [ :aCachedElement :theAttribute | "do nothing" ].
]

{ #category : #accessing }
GtCachedAttribute >> onCachingDo: aBlock [
	self 
		assert: [ aBlock notNil ]
		description: [ 'On caching block must be non-nil' ].
	onCachingAction := aBlock
]

{ #category : #printing }
GtCachedAttribute >> printOn: aStream [
	aStream nextPutAll: 'cached '.
	self attribute printOn: aStream
]

{ #category : #testing }
GtCachedAttribute >> shouldAppend [
	^ self attribute shouldAppend
]

{ #category : #testing }
GtCachedAttribute >> shouldReplace [
	^ self attribute shouldReplace
]

{ #category : #initialization }
GtCachedAttribute >> storeOn: aStream [
	super storeOn: aStream.
	
	aStream
		nextPutAll: ' attribute: ';
		nextPut: $(;
		store: attribute;
		nextPut: $)
]

{ #category : #private }
GtCachedAttribute >> updateCache: aBlElement [
	self cache: aBlElement.
	onCachingAction glamourValueWithArgs: { aBlElement. self }
]
