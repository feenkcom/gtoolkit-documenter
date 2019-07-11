Class {
	#name : #GtSlidesAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'slides'
	],
	#category : #'GToolkit-Documenter-Annotations'
}

{ #category : #protected }
GtSlidesAnnotation class >> possibleParameters [
	^ {
		self constants slidesParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
GtSlidesAnnotation class >> tag [
	^ self constants slidesAnnotationName
]

{ #category : #testing }
GtSlidesAnnotation >> hasSlidesDefined [
	<return: #Bollean>
	^ self slides isNotNil
]

{ #category : #testing }
GtSlidesAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self hasSlidesDefined
]

{ #category : #accessing }
GtSlidesAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"

	^ (GtSlider new
		slides:
			(self slides
				collect: [ :eachClassName | (self class environment at: eachClassName) new ]))
		asElement
]

{ #category : #'accessing - parameter values' }
GtSlidesAnnotation >> slides [
	<return: #Collection of: #GtSlide>
	<return: nil>
	^ slides ifNil: [ slides := self slidesParameterValues ]
]

{ #category : #'accessing - parameter values' }
GtSlidesAnnotation >> slidesParameterValues [
	<return: #Collection of: #GtSlide>
	<return: nil>
	^ self utility
		valueOf: self constants slidesParameterName
		in: self parameters
		value: [ :aValue | 
			aValue isCollection
				ifTrue: [ (aValue
						allSatisfy: [ :eachSlide | 
							eachSlide isSymbol
								and: [ (self class environment includesKey: eachSlide)
										and: [ (self class environment at: eachSlide) inheritsFrom: GtSlide ] ] ])
						ifTrue: [ aValue ]
						ifFalse: [ nil ] ]
				ifFalse: [ nil ] ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #'api - style' }
GtSlidesAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self utility subtleMarkupsInText: aBlRope start: self start stop: self stop.
	self hasSlidesDefined ifFalse: [ ^ self ].
	self styleExpandingPreviewInText: aBlRope.
	
]

{ #category : #'api - style' }
GtSlidesAnnotation >> styleTextWithoutMarkup: aBlRope [ 
	super styleTextWithoutMarkup: aBlRope.
	self utility subtleMarkupsInText: aBlRope start: self start stop: self stop.
	self hasSlidesDefined ifFalse: [ ^ self ].
	(self nodeStyler: aBlRope)
		if: self hasSlidesDefined 
			do: [ :aStyler | aStyler autoHideNode ]. 
	self utility stylePreviewInText: aBlRope forNode: self.
]
