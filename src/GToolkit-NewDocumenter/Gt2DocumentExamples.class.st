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

{ #category : #'method - existing one' }
Gt2DocumentExamples >> contentWithExistingMethodAnnotation [
	<gtExample>
	^ '${', self constants methodAnnotationName, ':', self referencedMethod printString, '}$'

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

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentWithEditedExistingMethodAnnotation [
	<gtExample>
	| aDocument |
	aDocument := self documentWithExistingMethodAnnotation.
	self examplesUtility 
		insertText: self fooText
		at: (self contentWithExistingMethodAnnotation size - 2)
		in: aDocument text.
	self assert: (aDocument text asString = self contentWithExistingMethodAnnotation) not.
	self 
		assert: (aDocument text asString allButLast: (2 + self fooText size)) 
		equals: (self contentWithExistingMethodAnnotation allButLast: 2).
	self assert: aDocument isRegisteredToSystem.
	^ aDocument
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentWithExistingMethodAnnotation [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethodAnnotation.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethodAnnotation.
	self assert: aDocument isRegisteredToSystem.
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
	^ aDocument
]

{ #category : #accessing }
Gt2DocumentExamples >> examplesUtility [
	^ Gt2DocumentExamplesUtility
]

{ #category : #basic }
Gt2DocumentExamples >> fooText [
	<gtExample>
	^ 'Foo' asRopedText
]

{ #category : #'pillar parser' }
Gt2DocumentExamples >> parseRopedTextContent [
	<gtExample>
	"This one does not work yet. We need to improve Petit Parser to delegate string comparision."
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethodAnnotation asRopedText.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
Gt2DocumentExamples >> parseStringContent [
	<gtExample>
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethodAnnotation.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
Gt2DocumentExamples >> pillarParser [
	<gtExample>
	^ PRPillarParser new optimize.
	
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
