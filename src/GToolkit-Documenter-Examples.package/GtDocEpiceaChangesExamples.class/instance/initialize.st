initialization
initialize
	"We do define a globaly unique repository name because 
	${class:OmStoreFactory} uses full file name as an unique key."
	super initialize.
	fileSystemExamples rootDirectoryName: UUID new asString.