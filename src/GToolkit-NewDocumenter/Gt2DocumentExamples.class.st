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

{ #category : #codeblock }
Gt2DocumentExamples >> contentWithCodeblock [
	<gtExample>
	^ '[[[label=Evaluate
4 factorial.
]]]'

]

{ #category : #codeblock }
Gt2DocumentExamples >> contentWithCodeblockAndEmptyLineAfter [
	<gtExample>
	^ '[[[label=Evaluate
4 factorial.
]]]
'

]

{ #category : #'class - existing one' }
Gt2DocumentExamples >> contentWithExistingClass [
	<gtExample>
	^ '${', self constants classAnnotationName, ':', self referencedClass , '}$'

]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> contentWithExistingExample [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', self referencedExampleMethod printString, '}$'

]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> contentWithExistingMethod [
	<gtExample>
	^ '${', self constants methodAnnotationName, ':', self referencedMethod printString, '}$'

]

{ #category : #'method - multiple' }
Gt2DocumentExamples >> contentWithMultipleMethods [
	<gtExample>
	^ '${', self constants methodAnnotationName, 
			':', self referencedMethod printString,
			'|', self constants expandedParameterName, '}$', String cr, String cr,
	
		'${', self constants methodAnnotationName, 
			':', self referencedMethod printString,
			'|', self constants expandedParameterName,
			'|', self constants showParameterName, '=gtSourceFor:', '}$', String cr, String cr
]

{ #category : #'empty document' }
Gt2DocumentExamples >> defaultDocument [
	<gtExample>
	| aDocument |
	aDocument := Gt2Document new.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentDeleteAll [
	<gtExample>
	| aDocument |
	aDocument := self documentWithExistingMethod.
	self examplesUtility 
		deleteText: aDocument text 
		from: 1
		to: self contentWithExistingMethod size.
	aDocument editor styleText.
	self 
		assert: aDocument text asString 
		equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentDeleteMethodAnnotation [
	<gtExample>
	| aDocument |
	aDocument := self documentWithExistingMethod.
	self examplesUtility 
		deleteText: aDocument text 
		from: 1
		to: self contentWithExistingMethod size - 1.
	aDocument editor styleText.
	self 
		assert: aDocument text asString 
		equals: ( self contentWithExistingMethod last asString).
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #codeblock }
Gt2DocumentExamples >> documentWithCodeblock [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblock.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithCodeblock.
	"self assert: aDocument isSubscribedToSystem."
	^ aDocument
]

{ #category : #codeblock }
Gt2DocumentExamples >> documentWithCodeblockAndEmptyLineAfter [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblockAndEmptyLineAfter.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithCodeblockAndEmptyLineAfter.
	"self assert: aDocument isSubscribedToSystem."
	^ aDocument
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentWithEditedExistingMethodAnnotation [
	<gtExample>
	| aDocument |
	aDocument := self documentWithExistingMethod.
	self examplesUtility 
		insertText: self fooText
		at: (self contentWithExistingMethod size - 2)
		in: aDocument text.
	self assert: (aDocument text asString = self contentWithExistingMethod) not.
	self 
		assert: (aDocument text asString allButLast: (2 + self fooText size)) 
		equals: (self contentWithExistingMethod allButLast: 2).
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'class - existing one' }
Gt2DocumentExamples >> documentWithExistingClass [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingClass.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingClass.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> documentWithExistingExample [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingExample.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingExample.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentWithExistingMethod [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethod.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethod.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'method - multiple' }
Gt2DocumentExamples >> documentWithMultipleMethods [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithMultipleMethods.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithMultipleMethods.
	self assert: aDocument isSubscribedToSystem.
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
	self assert: aDocument isSubscribedToSystem not.
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
	aPRDocument := self pillarParser parse: self contentWithExistingMethod asRopedText.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
Gt2DocumentExamples >> parseStringContent [
	<gtExample>
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethod.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
Gt2DocumentExamples >> pillarParser [
	<gtExample>
	^ PRPillarParser new optimize.
	
]

{ #category : #'class - existing one' }
Gt2DocumentExamples >> referencedClass [
	<gtExample>
	^ self className
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> referencedExampleMethod [
	<gtExample>
	^ self class >> #documentWithMultipleMethods
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
	self assert: aDocument isSubscribedToSystem.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument).
	aDocument unsubscribe: self.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]
