Class {
	#name : #GtEpiceaMethodViewerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #'method definition' }
GtEpiceaMethodViewerExamples >> methodClassName [
	<gtExample>
	^ 'NotExistingClass'
]

{ #category : #'method definition' }
GtEpiceaMethodViewerExamples >> methodPackageName [
	<gtExample>
	^ #'GToolkitNotExistingPackage'
]

{ #category : #'method definition' }
GtEpiceaMethodViewerExamples >> methodSourceCode [
	<gtExample>
	^ self selectorName, ' anInputVariable
	"a comment" 
	| aTempOne | 
	aTempOne := self notExistingMethod.
	aTempTwo := aTempOne.
	instanceVarOne := NotExistingClass maxNumber + 23 + 56.
	^ self returnValue'
]

{ #category : #'method definition' }
GtEpiceaMethodViewerExamples >> methodTimeStamp [
	<gtExample>
	^ 'AuthorOne 5/20/2018 23:52'
]

{ #category : #'method definition' }
GtEpiceaMethodViewerExamples >> notExistingMethodDefinition [
	<gtExample>
	^ (RGMethodDefinition named: self selectorName)
		parentName: self methodClassName;
		isMetaSide: false;
		protocol: 'not-existing-protocol';
		sourceCode: self methodSourceCode;
		stamp: self methodTimeStamp;
		package: self methodPackageName;
		yourself.

]

{ #category : #viewer }
GtEpiceaMethodViewerExamples >> notExistingMethodViewer [
	<gtExample>
	^ GtEpiceaMethodViewer fromDefinition: self notExistingMethodDefinition
]

{ #category : #'method definition' }
GtEpiceaMethodViewerExamples >> selectorName [
	<gtExample>
	^ 'notExistingMethod:'

]
