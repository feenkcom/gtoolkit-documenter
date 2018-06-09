binding
at: anInteger 
	"I am used as (outs at: index) in a Pillar codeblock.
	I return a result of a codeblock execution."
	^ (self documentPartAt: anInteger) 
		ifNotNil: [ :aGtPillarDocumentExecutablePart | 
			aGtPillarDocumentExecutablePart result ]