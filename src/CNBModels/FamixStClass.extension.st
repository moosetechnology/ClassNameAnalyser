Extension { #name : #FamixStClass }

{ #category : #'*CNBModels' }
FamixStClass >> classModelAccordingTo: aMotherClass [

	^ CNBClassModel new 
							reference: self;
							name: self name;
							root: (self rootAccordingTo: aMotherClass);
							superclass: self superclass;
							suffix: (CNBFeatureSelector new extractSuffixFrom: self name);
							prefix: (CNBFeatureSelector new extractPrefixFrom: self name)
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
