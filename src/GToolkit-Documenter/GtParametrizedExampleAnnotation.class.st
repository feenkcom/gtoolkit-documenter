Class {
	#name : #GtParametrizedExampleAnnotation,
	#superclass : #GtExampleAnnotation,
	#category : 'GToolkit-Documenter-Annotations'
}

{ #category : #accessing }
GtParametrizedExampleAnnotation class >> possibleParameters [
	^ super possibleParameters , { self constants inputVariablesParameterName }
]

{ #category : #protected }
GtParametrizedExampleAnnotation class >> tag [
	^ self constants parametrizedExampleAnnotationName
]

{ #category : #visitor }
GtParametrizedExampleAnnotation >> accept: aVisitor [
	^ aVisitor visitGtParametrizedExampleAnnotation: self
]

{ #category : #'private - cache' }
GtParametrizedExampleAnnotation >> example [
	example ifNil: [ 
		example := self referencedExample compiledMethod gtParametrizedExample asExampleWithResult.
		self subscribeToExample ].
	^ example
]

{ #category : #'accessing - parameter values' }
GtParametrizedExampleAnnotation >> inputVariableNames [
	<return: #Collection of: #Symbol>
	^ self utility 
		valueOf: self constants inputVariablesParameterName
		in: self parameters
		value: [ :aStringOrCollection | 
			(aStringOrCollection isString or: [ aStringOrCollection isSymbol ])
				ifTrue: [ (Character space split: aStringOrCollection asString) 
					select: [ :eachSubString | eachSubString trimBoth isNotEmpty ]
					thenCollect: #asSymbol ]
				ifFalse: [ aStringOrCollection isCollection 
					ifTrue: [ aStringOrCollection ] 
					ifFalse: [ #() ] ] ]
		emptyValue: [ #() ]
		defaultValue: [ #() ]
]

{ #category : #'api - styling' }
GtParametrizedExampleAnnotation >> styleText: aBlRope using: aGt2StylerStrategy [
	super styleText: aBlRope using: aGt2StylerStrategy.
	self updateExampleArguments.
]

{ #category : #'private - cache' }
GtParametrizedExampleAnnotation >> updateExampleArguments [
	| theVariableValues |
	theVariableValues := OrderedCollection new: self inputVariableNames size.
	self inputVariableNames do: [ :eachVariableName |
		(self gtDocument variableBindings hasBindingOf: eachVariableName asSymbol)
			ifTrue: [ theVariableValues addLast: (self gtDocument variableBindings
				bindingOf: eachVariableName asSymbol) value ] ].
	theVariableValues size = self cachedExample numberOfRequieredArguments
		ifFalse: [ ^ self ].
	self cachedExample changeArguments: theVariableValues asArray.
]
