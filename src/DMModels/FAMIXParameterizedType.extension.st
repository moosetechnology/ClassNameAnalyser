Extension { #name : #FAMIXParameterizedType }

{ #category : #'*DMModels' }
FAMIXParameterizedType >> root [
	self isTrait
		ifTrue: [ ^ self ].
	({'ProtoObject' . 'Object'} includes: self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = 'Object'
		ifTrue: [ ^ self ].
	^ self superclass root
]
