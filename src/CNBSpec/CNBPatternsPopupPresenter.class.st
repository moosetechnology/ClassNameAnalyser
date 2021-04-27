"
I am the presenter containing the Class Names Distribution patterns descriptions.
"
Class {
	#name : #CNBPatternsPopupPresenter,
	#superclass : #CNBPopupPresenter,
	#category : #CNBSpec
}

{ #category : #'as yet unclassified' }
CNBPatternsPopupPresenter class >> patternsDescription [

	| fatBlob snowFlakes homogeneityBreaker intruder confetti homogeneous scatteredVocabulary stream pause |
	stream := (String new: 300) writeStream.
	pause := '*********************************'.
	
	fatBlob := 'Fat Blob: usually I am the only one of my kind per package. I hold several classes of my hierarchy which use the same token. Thus, my hierarchy follows a naming pattern'.
	
	homogeneityBreaker := 'Homogeneity-Breaker: do not confuse me with the intruder anti-pattern. The same tokens I hold can be found elsewhere in other packages, therefore I may mark common words in the project'.
	
	homogeneous := 'Homogeneous: I am the only token my dominant hierarchy uses, therefore my hierarchy is consistenty named. However, you may want to consider that other hierarchies might also be using me, an indicator of such case: more than one root class in my box.'.
	
	intruder := 'Intruder: I represent classes that share the same suffix with other hierarchies. I may point to a misconception or bad naming '.
	
	confetti := 'Confetti: multiple hierarchies use this suffix, my suffixes are not used much in other packages'.
	
	snowFlakes := 'Snow flakes: my classes fall independently from hierarchies. I represent  traits and solo classes that belong to no hierarchy. However, you may want to check my mono classes in case of a missed oppurtunity to group them into a single hierarchy'.
	
	
	scatteredVocabulary := 'Scattered Vocabulary: my hierarchy uses and dominates several tokens, it is not consistently named/does not follow a particular naming pattern.'.
	
	stream nextPutAll: 'Patterns:'; cr;
	nextPutAll: fatBlob; cr; cr;
	nextPutAll: homogeneityBreaker ; cr;  cr;
	nextPutAll: homogeneous ; cr; nextPutAll: pause; cr;
	nextPutAll: 'Anti-Patterns:'; cr;
	nextPutAll: intruder ; cr;  cr;
	nextPutAll: confetti; cr; cr;
	nextPutAll: snowFlakes ;cr; cr;
	nextPutAll: scatteredVocabulary ; cr; cr.
	^ stream contents
	

]

{ #category : #initialization }
CNBPatternsPopupPresenter >> initializePresenters [
	super initializePresenters.
	help := self newText text: self class patternsDescription.
	okButton := self newButton 
		label: 'Ok';
		action: [ self owner dismiss ];
		yourself
]
