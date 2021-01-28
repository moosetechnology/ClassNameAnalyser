Extension { #name : #Object }

{ #category : #'*DMModels' }
Object class >> rootAccordingTo: aMotherClass [

	self isTrait
		ifTrue: [ ^ self ].
	(aMotherClass = self name)
		ifTrue: [ ^ self ].
	self superclass isNotNil
		ifFalse: [ ^ self ].
	self superclass name = aMotherClass name
		ifTrue: [ ^ self ].
	^ self superclass rootAccordingTo: aMotherClass 
	
]
