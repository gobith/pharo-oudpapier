Class {
	#name : #GeoOPCollectionAfternoon,
	#superclass : #GeoOPCollectionPartTime,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #'as yet unclassified' }
GeoOPCollectionAfternoon class >> partTimeName [

	^'afternoon'
]

{ #category : #accessing }
GeoOPCollectionAfternoon >> fromDate: aDate [ 

	dateAndTime := aDate asDateAndTime + 12 hours
]

{ #category : #printing }
GeoOPCollectionAfternoon >> longName [
	^'Middag'
]

{ #category : #printing }
GeoOPCollectionAfternoon >> partTimeString [

	^'afternoon'
]

{ #category : #printing }
GeoOPCollectionAfternoon >> postFixString [

	^'in de middag'
]

{ #category : #printing }
GeoOPCollectionAfternoon >> shortName [
	^'M'
]

{ #category : #accessing }
GeoOPCollectionAfternoon >> startTimeString [

	^'13:30'
]

{ #category : #accessing }
GeoOPCollectionAfternoon >> userCollectionDayClass [

	^GeoOPUserCollectionAfternoon 
]
