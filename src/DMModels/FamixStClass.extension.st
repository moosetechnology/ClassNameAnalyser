Extension { #name : #FamixStClass }

{ #category : #'*DMModels' }
FamixStClass >> root [

	(self isTrait) 
	ifTrue: [ ^self ].
	
	({'ProtoObject' . 'Object'} includes: self name)
	ifTrue: [ ^self ].
	
	(self superclass isNotNil) ifTrue: [  
	(self superclass name = 'Object')
	ifTrue: [ ^self ].

	^self superclass root]
	
]
