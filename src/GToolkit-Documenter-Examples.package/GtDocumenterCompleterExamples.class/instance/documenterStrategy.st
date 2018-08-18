completion
documenterStrategy
	<gtExample>
	| completionStrategy |
	completionStrategy := GtDocumenterCompletionStrategy new.
	completionStrategy fileReference: self fileReference.
	^ completionStrategy