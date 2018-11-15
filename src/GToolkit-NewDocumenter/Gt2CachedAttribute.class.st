Class {
	#name : #Gt2CachedAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'attribute',
		'cache',
		'onCachingAction'
	],
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #accessing }
Gt2CachedAttribute >> affect: aBrText in: anEditorElement [
	^ self hasCache 
			ifTrue: [ self cache removeFromParent ]
			ifFalse: [ | anElement |
				anElement := self attribute affect: aBrText in: anEditorElement.
				self updateCache: anElement.
				anElement ]
]

{ #category : #accessing }
Gt2CachedAttribute >> attribute [
	^ attribute
]

{ #category : #accessing }
Gt2CachedAttribute >> attribute: anObject [
	attribute := anObject
]

{ #category : #accessing }
Gt2CachedAttribute >> beAppend [
	super beAppend.
	self attribute beAppend.
]

{ #category : #accessing }
Gt2CachedAttribute >> beReplace [
	super beReplace.
	self attribute beReplace.
]

{ #category : #accessing }
Gt2CachedAttribute >> cache [
	<return: #BlElement or: nil>
	^ cache
]

{ #category : #accessing }
Gt2CachedAttribute >> cache: aBlElement [
	cache := aBlElement.
]

{ #category : #testing }
Gt2CachedAttribute >> hasCache [
	^ self cache notNil
]

{ #category : #initialization }
Gt2CachedAttribute >> initialize [
	super initialize.
	attribute := Gt2PreviewAttribute new.
	cache := nil.
	onCachingAction := [ :aCachedElement :theAttribute | "do nothing" ].
]

{ #category : #accessing }
Gt2CachedAttribute >> onCachingDo: aBlock [
	self 
		assert: [ aBlock notNil ]
		description: [ 'On caching block must be non-nil' ].
	onCachingAction := aBlock
]

{ #category : #printing }
Gt2CachedAttribute >> printOn: aStream [
	aStream nextPutAll: 'cached '.
	self attribute printOn: aStream
]

{ #category : #testing }
Gt2CachedAttribute >> shouldAppend [
	^ self attribute shouldAppend
]

{ #category : #testing }
Gt2CachedAttribute >> shouldReplace [
	^ self attribute shouldReplace
]

{ #category : #private }
Gt2CachedAttribute >> updateCache: aBlElement [
	self cache: aBlElement.
	onCachingAction glamourValueWithArgs: { aBlElement. self }
]
