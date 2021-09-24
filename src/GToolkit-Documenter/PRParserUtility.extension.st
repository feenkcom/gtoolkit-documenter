Extension { #name : 'PRParserUtility' }

{ #category : '*GToolkit-Documenter' }
PRParserUtility class >> gtFixAndValidateParameters: aPRParameters for: anInstance [
	| aDictionary |
	self fixFirstParameter: aPRParameters for: anInstance.
	aDictionary := PRParametersToOrderedDictionary of: aPRParameters.
	self gtValidateParameters: aPRParameters dictionary: aDictionary in: anInstance.
	^ anInstance
		hadAllKeys:
			(anInstance gtDocumenterParameters
				difference: (aDictionary keys collect: #asSymbol)) isEmpty;
		parameters: aDictionary;
		yourself
]

{ #category : '*GToolkit-Documenter' }
PRParserUtility class >> gtValidateParameters: aPRParameters dictionary: parametersDictionary in: anAnnotation [
	| usedKeys |
	usedKeys := parametersDictionary keys.
	usedKeys isEmpty
		and: [ anAnnotation class hasParameters
				ifTrue: [ PRValidation strategy missingAnnotationParametersIn: anAnnotation ] ].
	(usedKeys
		allSatisfy: [ :each | anAnnotation class gtDocumenterParameters includes: each asSymbol ])
		ifFalse: [ PRValidation strategy
				invalidParameterNames: (usedKeys difference: anAnnotation class gtDocumenterParameters)
				forAnnotation: anAnnotation
				withParameters: aPRParameters ].
	anAnnotation class hasParameters not
		and: [ usedKeys isNotEmpty
				ifTrue: [ PRValidation strategy unexpectedParameterIn: anAnnotation ] ]
]
