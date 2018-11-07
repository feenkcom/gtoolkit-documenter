Class {
	#name : #Gt2CachedAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
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
				self cache: anElement.
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
Gt2CachedAttribute >> cache [
	<return: #BlElement or: nil>
	^ cache
]

{ #category : #accessing }
Gt2CachedAttribute >> cache: aBlElement [
	cache := aBlElement.
	onCachingAction glamourValueWithArgs: { aBlElement. self }
]

{ #category : #testing }
Gt2CachedAttribute >> hasCache [
	^ self cache notNil
]

{ #category : #initialization }
Gt2CachedAttribute >> initialize [
	super initialize.
	attribute := nil.
	cache := nil.
	onCachingAction := [ :aCachedElement :theAttribute | "do nothing" ].
]

{ #category : #accessing }
Gt2CachedAttribute >> onCachingDo: aBlock [
	onCachingAction := aBlock
]

{ #category : #testing }
Gt2CachedAttribute >> shouldAppend [
	^ self attribute shouldAppend
]

{ #category : #testing }
Gt2CachedAttribute >> shouldReplace [
	^ self attribute shouldReplace
]
