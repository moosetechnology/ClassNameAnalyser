Class {
	#name : #DMClassModel,
	#superclass : #DMModel,
	#instVars : [
		'name',
		'concept',
		'root',
		'superclass',
		'level'
	],
	#category : #DMConceptualModel
}

{ #category : #viewModel }
DMClassModel >> classViewModel [

	^DMClassViewModel name: self name with: 'not yet'
]

{ #category : #accessing }
DMClassModel >> concept [
	^concept
]

{ #category : #accessing }
DMClassModel >> concept: className [

	concept := DMFeatureSelector new extractConceptFrom: className
]

{ #category : #accessing }
DMClassModel >> level [
	^level
]

{ #category : #accessing }
DMClassModel >> level: aLevel [

	level := aLevel
]

{ #category : #accessing }
DMClassModel >> name [
	^name
]

{ #category : #accessing }
DMClassModel >> name: aName [
	name:= aName.
	self concept: self name.
]

{ #category : #initialization }
DMClassModel >> name: className with: itsRootClassName [

	self name: className.
	self root: itsRootClassName.
	self concept: self name.
]

{ #category : #accessing }
DMClassModel >> root [
	^root
]

{ #category : #accessing }
DMClassModel >> root: aRootClassName [
	root := aRootClassName 
]

{ #category : #accessing }
DMClassModel >> superclass [
	^superclass
]

{ #category : #accessing }
DMClassModel >> superclass: aFamixClass [
	superclass := aFamixClass 
]
