Extension { #name : #FamixStPackage }

{ #category : #'*DMConceptualModel' }
FamixStPackage >> classmodels [
	^self localClasses collect: [ :each | each classmodel ]
	
]

{ #category : #'*DMConceptualModel' }
FamixStPackage >> conceptualClassModels [ 
	^DMClassModelGroup new addAll: (self classmodels)
]

{ #category : #'*DMConceptualModel' }
FamixStPackage >> packagemodel [
	^DMPackageModel name: self name with: self classmodels  
]
