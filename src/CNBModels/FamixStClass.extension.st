Extension { #name : #FamixStClass }

{ #category : #'*CNBModels' }
FamixStClass >> classModelAccordingTo: setting [

	^ CNBClassModel of: self accordingTo: setting

]

{ #category : #'*CNBModels' }
FamixStClass >> rootAccordingTo: aRootClassName [

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
