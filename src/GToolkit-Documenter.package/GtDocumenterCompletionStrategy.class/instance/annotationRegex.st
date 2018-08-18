private
annotationRegex
	^ '(\$\{([^$:| \s}]*))(([:|](([-a-zA-Z0-9]+=)?[^|}[:cntrl:]]+)*)*)(}?\$?)' asRegex