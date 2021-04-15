Extension { #name : #Dictionary }

{ #category : #'*CNBModels' }
Dictionary >> detectMaxAssociation [ 
	
	| maxValue |
	((self values allSatisfy: [ :each | each isNumber ]) and: [ self hasMoreThanOneElement ] ) 
	ifFalse: [ ^ self ].
	
	maxValue := self values detectMax: [ :each | each ].
	^ self associations detect: [ :each | each value = maxValue  ]

]
