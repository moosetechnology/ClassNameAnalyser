Extension { #name : #FAMIXType }

{ #category : #'*CNBModels' }
FAMIXType >> rootAccordingTo: aRootClassName [

	self isTrait
		ifTrue: [ ^ self ].
	(aRootClassName = self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = aRootClassName
		ifTrue: [ ^ self ].
	^ self superclass rootAccordingTo: aRootClassName 
	
]
