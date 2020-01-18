Extension { #name : #MooseGroup }

{ #category : #'*DMConceptualModel' }
MooseGroup >> packagemodels [
	^self collect: [ :each | each packagemodel ]
]
