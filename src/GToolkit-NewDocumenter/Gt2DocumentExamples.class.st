Class {
	#name : #Gt2DocumentExamples,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants + TBlDebug',
	#classTraits : 'TGt2DocumentConstants classTrait + TBlDebug classTrait',
	#category : #'GToolkit-NewDocumenter-Examples'
}

{ #category : #accessing }
Gt2DocumentExamples class >> constants [
	^ Gt2DocumentConstants
]

{ #category : #accessing }
Gt2DocumentExamples >> constants [
	^ Gt2DocumentConstants
]

{ #category : #'empty document' }
Gt2DocumentExamples >> defaultDocument [
	<gtExample>
	| aDocument |
	aDocument := Gt2Document new.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isRegisteredToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #'empty document' }
Gt2DocumentExamples >> emptyContent [
	<gtExample>
	^ ''

]

{ #category : #'empty document' }
Gt2DocumentExamples >> emptyDocument [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self emptyContent.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isRegisteredToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	"self flag: 'self assert: aDocument bindings notNil'."
	^ aDocument
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> pillarContentWithExistingMethodAnnotation [
	<gtExample>
	^ '${method:', self referencedMethod printString, '}$'

]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> referencedMethod [
	<gtExample>
	^ self class >> #referencedMethod
]

{ #category : #'empty document' }
Gt2DocumentExamples >> registeredDocument [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument.
	aDocument subscribe: SystemAnnouncement do: [ :anAnnouncement | "ignore" ] for: self.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isRegisteredToSystem.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument).
	aDocument unsubscribe: self.
	self assert: aDocument isRegisteredToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]
