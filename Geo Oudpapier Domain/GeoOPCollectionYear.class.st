Class {
	#name : #GeoOPCollectionYear,
	#superclass : #Object,
	#instVars : [
		'year',
		'months'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPCollectionYear class >> neoJsonMappingOn: mapping [

	"year months"

	mapping
		mapInstVar: #year;
		mapInstVar: #months
]

{ #category : #testing }
GeoOPCollectionYear >> isVisible [

	^(self months select: [ : month | month isVisible ]) size > 0
]

{ #category : #accessing }
GeoOPCollectionYear >> months [
	^ months
]

{ #category : #accessing }
GeoOPCollectionYear >> months: anObject [
	months := anObject
]

{ #category : #accessing }
GeoOPCollectionYear >> numberOfPartTimes [

	^months sum: [ : month | month numberOfPartTimes ]
]

{ #category : #accessing }
GeoOPCollectionYear >> numberOfVisiblePartTimes [

	^months sum: [ : month | month numberOfVisiblePartTimes ]
]

{ #category : #accessing }
GeoOPCollectionYear >> year [
	^ year
]

{ #category : #accessing }
GeoOPCollectionYear >> year: anObject [
	year := anObject
]

{ #category : #accessing }
GeoOPCollectionYear >> yearString [

	^year asString
]
