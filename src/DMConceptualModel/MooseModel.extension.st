Extension { #name : #MooseModel }

{ #category : #'*DMConceptualModel' }
MooseModel >> buildConceptualModel [
	^ DMBuilder buildConceptualModelFrom: self

]
