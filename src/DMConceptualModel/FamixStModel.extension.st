Extension { #name : #FamixStModel }

{ #category : #'*DMConceptualModel' }
FamixStModel >> buildConceptualModel [
	^ self buildConceptualModelFrom: (self allModelPackages ifNil: self allModelNamespaces ) asMooseGroup 

]
