Class {
	#name : #GeoOPCollectionMorning,
	#superclass : #GeoOPCollectionPartTime,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #'as yet unclassified' }
GeoOPCollectionMorning class >> partTimeName [

	^'morning'
]

{ #category : #accessing }
GeoOPCollectionMorning >> fromDate: aDate [ 

	dateAndTime := aDate asDateAndTime
]

{ #category : #testing }
GeoOPCollectionMorning >> isMorning [

	^true
]

{ #category : #printing }
GeoOPCollectionMorning >> longName [

	^'Ochtend'
]

{ #category : #printing }
GeoOPCollectionMorning >> partTimeString [

	^'morning'
]

{ #category : #printing }
GeoOPCollectionMorning >> postFixString [

	^'in de ochtend'
]

{ #category : #printing }
GeoOPCollectionMorning >> shortName [

	^'O'
]

{ #category : #accessing }
GeoOPCollectionMorning >> startTimeString [

	^ title = 'Ten Oosten van het Lint (Ochtend)'
		ifTrue: [ '8:30' ]
		ifFalse: [ '9:00' ]
]

{ #category : #accessing }
GeoOPCollectionMorning >> userCollectionDayClass [

	^GeoOPUserCollectionMorning
]
