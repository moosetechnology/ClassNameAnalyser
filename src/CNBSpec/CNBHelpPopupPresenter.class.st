Class {
	#name : #CNBHelpPopupPresenter,
	#superclass : #CNBPopupPresenter,
	#category : #CNBSpec
}

{ #category : #accessing }
CNBHelpPopupPresenter class >> help [ 
	| definition boxes colorsMeaning pause whiteColorMeaning grayColorMeaning blackColorMeaning tokenColorMeaning stream |
	
	stream := (String new: 300) writeStream.
	pause := '*********************************'.
	 definition := 'ClassNames Distrubution is a package-centered visualisation of the class tokens (suffix, prefix, both) distribution across packages, from an iheritance perspective. The visualisation is based on boxes and colors'.
		
		boxes := 'Class boxes are placed inside token boxes inside package boxes.'.
		
		whiteColorMeaning 
			:= 'White color is to represent traits classes and solo classes that belong to no hierarchy'.
			
		grayColorMeaning
			:= 'Gray is to represent hierarchies that follow a particular naming pattern which is the use of one and only token across the hierarchy.'.
			
			colorsMeaning := 'Besides the white, gray and black colors. All the other colors represent each a hierarchy. Therefore, a color means a hierarchy of classes. These classes do not follow a particular naming schema and may hide misnaming, inconsistencies or bad conception'.
			
			blackColorMeaning := 'The visualisations represents 24 main hierarchies, starting from the 25th hierarchy classes are colored in black'.
			
			tokenColorMeaning := 'The color of the token boxes follows the color of the hierarchy that has the most use of the token.'.
			
	stream nextPutAll: definition; cr; nextPutAll: pause; cr;
		nextPutAll: boxes; cr; nextPutAll: pause; cr;
		nextPutAll: whiteColorMeaning; cr; nextPutAll: pause; cr;
		nextPutAll: grayColorMeaning; cr; nextPutAll: pause; cr;
		nextPutAll: colorsMeaning; cr; nextPutAll: pause; cr;
		nextPutAll: blackColorMeaning; cr; nextPutAll: pause; cr;
		nextPutAll: tokenColorMeaning; cr; nextPutAll: pause; cr.
		^ stream contents
]

{ #category : #initialization }
CNBHelpPopupPresenter >> initializePresenters [
	super initializePresenters.
	help := self newText text: self class help.
	okButton := self newButton 
		label: 'Ok';
		action: [ self owner dismiss ];
		yourself
]
