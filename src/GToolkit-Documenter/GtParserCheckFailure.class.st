Class {
	#name : 'GtParserCheckFailure',
	#superclass : 'Error',
	#instVars : [
		'source',
		'messages'
	],
	#category : 'GToolkit-Documenter-Styler'
}

{ #category : 'signalling' }
GtParserCheckFailure class >> signalSource: sourceText messages: messageCollection [

	^self new 
		initializeSource: sourceText messages: messageCollection;
		signal.
]

{ #category : 'initialization' }
GtParserCheckFailure >> initializeSource: sourceText messages: messageCollection [

	source := sourceText.
	messages := messageCollection.
	messageText := 'Unsafe source text'.

]

{ #category : 'private' }
GtParserCheckFailure >> isResumable [
	"It's OK to continue after this error has been signaled.
	The parser might just go in to an infinite loop."

	^true
]
