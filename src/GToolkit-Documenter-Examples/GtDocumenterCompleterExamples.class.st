Class {
	#name : #GtDocumenterCompleterExamples,
	#superclass : #GtCompleterExamples,
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #completion }
GtDocumenterCompleterExamples >> completeChanges [
	<gtExample>
	^ self openOn: '' withStrategy: self documenterStrategy entering: #(0 '${ch' #tabOn: ':aa' #tabOn: #tabOn: '}$')
	
	"${changes:aa/1}$"
]

{ #category : #completion }
GtDocumenterCompleterExamples >> completeExample [
	<gtExample>
	^ self openOn: '' withStrategy: self documenterStrategy entering: #(0 '${ex' #tabOn: ':GtDocumenterComplet' #tabOn: #tabOn: '}$')
	
	"${example:GtDocumenterCompleterExamples>>#completeExample}$"
]

{ #category : #completion }
GtDocumenterCompleterExamples >> documenterStrategy [
	<gtExample>
	| completionStrategy |
	completionStrategy := GtDocumenterCompletionStrategy new.
	completionStrategy fileReference: self fileReference.
	^ completionStrategy
]

{ #category : #completion }
GtDocumenterCompleterExamples >> drillDownChanges [
	<gtExample>
	^ self
		openOn: ''
		withStrategy: self documenterStrategy
		entering: #(0 '${ch' #tabOn: ':a') , {[ :controller | self selectPreviewMatching: '*aa*' in: controller ]} , #(#cmdRightOn:)

	"${changes:aa/1"	"with 1 being highlighted"
]

{ #category : #completion }
GtDocumenterCompleterExamples >> drillDownExample [
	<gtExample>
	^ self openOn: '' withStrategy: self documenterStrategy entering: #(0 '${ex' #tabOn: ':G' #cmdRightOn: #cmdRightOn: '}$')

	"${example:GClass>>#method}$"
]

{ #category : #completion }
GtDocumenterCompleterExamples >> fileReference [
	<gtExample>
	| dir |
	dir := FileSystem memory workingDirectory.
	#('a1' 'a2' 'a3') do: [ :each | dir / each writeStreamDo: [ :stream | stream nextPutAll: each ] ].
	#('aa' 'ab')
		do: [ :each | 
			| subdir |
			subdir := dir / each.
			subdir ensureCreateDirectory.
			1 to: 2 do: [ :i | 
				subdir / i printString
					writeStreamDo: [ :stream | 
						stream
							nextPutAll: each;
							nextPutAll: i printString ] ] ].
	^ dir
]

{ #category : #completion }
GtDocumenterCompleterExamples >> undoDrillDownAndEscapeExample [
	<gtExample>
	^ self openOn: '' withStrategy: self documenterStrategy entering: #(0 '${ex' #tabOn: ':G' #cmdRightOn: #cmdLeftOn: #escapeOn:)

	"${example:G"
]

{ #category : #completion }
GtDocumenterCompleterExamples >> undoDrillDownChanges [
	<gtExample>
	^ self
		openOn: ''
		withStrategy: self documenterStrategy
		entering: #(0 '${ch' #tabOn: ':a') , {[ :controller | self selectPreviewMatching: '*aa*' in: controller ]} , #(#cmdRightOn: #cmdLeftOn:)

	"${changes:aa/"	"with aa/ being highlighted"
]
