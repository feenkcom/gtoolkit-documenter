Class {
	#name : #GtExplanationAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'TBlDebug + TGtDocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGtDocumentConstants classTrait',
	#category : 'GToolkit-Documenter-Annotations'
}

{ #category : #protected }
GtExplanationAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		}
]

{ #category : #protected }
GtExplanationAnnotation class >> tag [
	^ self constants explanationAnnotationName
]

{ #category : #'api - style' }
GtExplanationAnnotation >> nameParameterValue [
	^ self utility 
			valueOf: self constants nameParameterName
			in: self parameters 
			value: [ :aValue | aValue asSymbol ] 
			emptyValue: [ nil ] 
			defaultValue: [ nil ]
]

{ #category : #'api - style' }
GtExplanationAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(self gtNodeStyler: aBlRope) 
		name: self nameParameterValue;
		explanation
]

{ #category : #'api - style' }
GtExplanationAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self gtNodeStyler: aBlRope) autoHideNode
]
