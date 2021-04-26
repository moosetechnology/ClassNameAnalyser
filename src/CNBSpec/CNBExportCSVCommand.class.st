"
I am responsible for exporting the CSV file of the Analysis description of the ClassNames Distribution.
"
Class {
	#name : #CNBExportCSVCommand,
	#superclass : #CmCommand,
	#category : #CNBSpec
}

{ #category : #initialization }
CNBExportCSVCommand class >> defaultIconName [ 

	^ MooseIcons mooseImportMse 
]

{ #category : #default }
CNBExportCSVCommand class >> defaultName [
	^ 'Export to CSV'
]

{ #category : #accessing }
CNBExportCSVCommand >> category [

	^ 'Import'
]

{ #category : #executing }
CNBExportCSVCommand >> execute [ 
	
	| file |
    file := UIManager default
                chooseForSaveFileReference: 'Chose export destination'
                extensions: #( 'csv' )
                path: 'properties.csv'.
    file ifNotNil: [ 
        context exportTo: file.
        UIManager default
            inform: 'Entities exported.
				Click to show in folder'
            actionOnClick: [ file openInOSFileBrowser ] ]


]

{ #category : #accessing }
CNBExportCSVCommand >> icon [
	^ MooseIcons mooseImportMse
]

{ #category : #accessing }
CNBExportCSVCommand >> label [
	^ 'Import model from MSE file'
]
