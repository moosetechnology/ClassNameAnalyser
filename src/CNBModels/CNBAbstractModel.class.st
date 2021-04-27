"
I am an abstract model of the Class Names Distribution models.
"
Class {
	#name : #CNBAbstractModel,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBAbstractModel class >> name: aName with: something [
	^self new name: aName with: something 
]

{ #category : #'as yet unclassified' }
CNBAbstractModel class >> name: aName with: something and: else [
	^self new name: aName with: something and: else
]

{ #category : #accessing }
CNBAbstractModel >> name [ 

	^ name
]

{ #category : #accessing }
CNBAbstractModel >> name: aName [

	name := aName asString
]
