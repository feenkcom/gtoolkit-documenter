"
I am a ${class:BrEditor}$ specific for ${class:GtDocumenter}$. 

I extend ${class:BrEditor}$ by: 
- ${class:GtDocumenterEditorNormalFontSizeModel}$,
- ${class:GtDocumenterEditorStorageModel}$,
- ${class:GtDocumenterEditorSystemSubscriptionModel}$, and
- ${class:GtDocumenterEditorVariableBindingsModel}$.

"
Class {
	#name : 'GtDocumenterEditor',
	#superclass : 'BrEditor',
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'normalFontSizeModel',
		'storageModel',
		'subscriptionModel',
		'variableBindindsModel'
	],
	#category : 'GToolkit-Documenter-! Editor - UI'
}

{ #category : 'api - announcer' }
GtDocumenterEditor >> announce: anAnnouncement [
	^ subscriptionModel announce: anAnnouncement
]

{ #category : 'api - storage' }
GtDocumenterEditor >> basename [
	<return: #String>
	^ storageModel basename
]

{ #category : 'api - storage' }
GtDocumenterEditor >> classComment: aClass [
	storageModel classComment: aClass
]

{ #category : 'api - styling' }
GtDocumenterEditor >> decreaseNormalFontSize [
	^ normalFontSizeModel decreaseNormalFontSize
]

{ #category : 'defaults' }
GtDocumenterEditor >> defaultParser [
	^ GtDocumenterParser new
]

{ #category : 'defaults' }
GtDocumenterEditor >> defaultStyler [
	^ GtDocumenterStyler new 
		document: self; 
		parser: self defaultParser;
		hideMarkup
]

{ #category : 'api - initialization' }
GtDocumenterEditor >> document: aGtDocumenter [
	self styler document: aGtDocumenter.
]

{ #category : 'api - storage' }
GtDocumenterEditor >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution.
	It is typically a class in case of class comment, file in case of file content, and nil in other cases."
	<return: #Object>
	^ storageModel evaluationReceiver
]

{ #category : 'api - storage' }
GtDocumenterEditor >> exists [
	<return: #Boolean>
	^ storageModel exists
]

{ #category : 'api - storage' }
GtDocumenterEditor >> fileReference: aFileReference [ 
	storageModel fileReference: aFileReference
]

{ #category : 'gt-extensions' }
GtDocumenterEditor >> gtVariableBindingsFor: aView [
	<gtView>
	variableBindindsModel ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Variables';
		priority: 3;
		object: [ variableBindindsModel ];
		view: #gtVariableBindingsFor:
]

{ #category : 'api - styling' }
GtDocumenterEditor >> increaseNormalFontSize [
	^ normalFontSizeModel increaseNormalFontSize
]

{ #category : 'initialization' }
GtDocumenterEditor >> initialize [
	super initialize.
	self viewModel add: (normalFontSizeModel := GtDocumenterEditorNormalFontSizeModel new).
	self viewModel add: (storageModel := GtDocumenterEditorStorageModel new).
	self viewModel add: (subscriptionModel := GtDocumenterEditorSystemSubscriptionModel new).
	self viewModel add: (variableBindindsModel := GtDocumenterEditorVariableBindingsModel new).
	self variableBindings
			localAt: self constants thisDocument 
			put: self.
	self editor stylerStrategy: GtDocumenterTimeLimitedTextStylerTaskItStrategy new.
	self styler: self defaultStyler.
]

{ #category : 'api - announcer' }
GtDocumenterEditor >> isSubscribedToSystem [
	<return: #Boolean>
	^ subscriptionModel isSubscribedToSystem
]

{ #category : 'api - storage' }
GtDocumenterEditor >> name [
	<return: #String>
	^ storageModel name
]

{ #category : 'api - styling' }
GtDocumenterEditor >> normalFontSize [
	<rerturn: #Number>
	^ normalFontSizeModel normalFontSize
]

{ #category : 'api - styling' }
GtDocumenterEditor >> normalFontSize: aNumber [
	normalFontSizeModel normalFontSize: aNumber
]

{ #category : 'api - storage' }
GtDocumenterEditor >> read [
	^ storageModel read
]

{ #category : 'api - storage' }
GtDocumenterEditor >> rootDirectory [
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ storageModel rootDirectory
]

{ #category : 'api - storage' }
GtDocumenterEditor >> save [
	^ storageModel save
]

{ #category : 'api - storage' }
GtDocumenterEditor >> storage [
	<return: #GtStorageStrategy>
	^ storageModel storage
]

{ #category : 'api - storage' }
GtDocumenterEditor >> store [
	self
		deprecated: 'Please use save method instead.'
		transformWith:
			'`@receiver store'
				-> '`@receiver save'.
	self save
]

{ #category : 'api - styling' }
GtDocumenterEditor >> styleTextRequest [
	self editor styleText
]

{ #category : 'api - announcer' }
GtDocumenterEditor >> systemAnnouncer [
	<return: #Announcer>
	^ subscriptionModel systemAnnouncer
]

{ #category : 'api - announcer' }
GtDocumenterEditor >> systemSubscriber [
	^ subscriptionModel systemSubscriber
]

{ #category : 'api - announcer' }
GtDocumenterEditor >> unsubscribe: aSubscriber [
	^ subscriptionModel unsubscribe: aSubscriber
]

{ #category : 'api - variables' }
GtDocumenterEditor >> variableBindings [
	<return: #TGtVariablesBindings>
	^ variableBindindsModel variableBindings
]

{ #category : 'api - variables' }
GtDocumenterEditor >> variableBindings: aGtSnippetBindings [
	variableBindindsModel variableBindings: aGtSnippetBindings
]
