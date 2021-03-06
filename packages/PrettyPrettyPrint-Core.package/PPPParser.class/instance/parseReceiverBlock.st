parse-message-receiver
parseReceiverBlock
	
	| receiver |
	
	receiver := PPPBlockNode new.
	self step.
	
	[ self nextToken isBlockBinding ]
		whileTrue: [ receiver addBinding: (self step: #identifier) content ].
	
	self flushCommentsTo: receiver.
	
	receiver bindings ifNotEmpty: [ self step: #special ].
	receiver bodySequence: self parseSequence.
	
	self step isClosingSquareBrace ifFalse: [ ^ self syntaxError ].
	
	^ receiver