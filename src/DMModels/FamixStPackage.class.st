Class {
	#name : #FamixStPackage,
	#superclass : #FamixStScopingEntity,
	#traits : 'FamixTCohesionCouplingMetrics + FamixTPackage',
	#classTraits : 'FamixTCohesionCouplingMetrics classTrait + FamixTPackage classTrait',
	#category : #DMModels
}

{ #category : #'*DMModels' }
FamixStPackage >> classmodels [
	^self classes collect: [ :each | each classmodel ]
]

{ #category : #'*DMModels' }
FamixStPackage >> conceptualClassModels [ 
	^DMClassModelGroup new addAll: (self classmodels)
]

{ #category : #'*DMModels' }
FamixStPackage >> packagemodel [

	^DMPackageModel new 
	name: self name;
	classmodels: self conceptualClassModels  
]
