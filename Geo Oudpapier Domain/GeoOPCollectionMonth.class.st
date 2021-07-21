Class {
	#name : #GeoOPCollectionMonth,
	#superclass : #Object,
	#instVars : [
		'monthObject',
		'month',
		'index',
		'days'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #'accessing constant' }
GeoOPCollectionMonth class >> monthNames [
	^ {'januari' . 'februari' . 'maart' . 'april' . 'mei' . 'juni' . 'juli' . 'augustus'.
	'september' . 'oktober' . 'november' . 'december'}
]

{ #category : #accessing }
GeoOPCollectionMonth class >> neoJsonMappingOn: mapping [

	"monthObject month index days"

	mapping
		mapInstVar: #index;
		mapInstVar: #month;
		mapAccessor: #year;
		mapInstVar: #days
]

{ #category : #accessing }
GeoOPCollectionMonth >> days [
	^ days
]

{ #category : #accessing }
GeoOPCollectionMonth >> days: anObject [
	days := anObject
]

{ #category : #accessing }
GeoOPCollectionMonth >> index [
	^ index
]

{ #category : #accessing }
GeoOPCollectionMonth >> index: anObject [
	index := anObject
]

{ #category : #initialization }
GeoOPCollectionMonth >> initialize [

	super initialize.
	days := OrderedCollection new
]

{ #category : #testing }
GeoOPCollectionMonth >> isVisible [

	^self numberOfVisiblePartTimes > 0 
]

{ #category : #accessing }
GeoOPCollectionMonth >> longMonthName [

	^self class monthNames at: index
]

{ #category : #printing }
GeoOPCollectionMonth >> longName [
	^self monthObject name
]

{ #category : #accessing }
GeoOPCollectionMonth >> month [
	^ month
]

{ #category : #accessing }
GeoOPCollectionMonth >> month: anObject [
	month := anObject
]

{ #category : #accessing }
GeoOPCollectionMonth >> monthObject [
	^ monthObject
]

{ #category : #accessing }
GeoOPCollectionMonth >> monthObject: anObject [
	monthObject := anObject
]

{ #category : #accessing }
GeoOPCollectionMonth >> numberOfPartTimes [
	^days sum: [ :day | day partTimes size ]
]

{ #category : #accessing }
GeoOPCollectionMonth >> numberOfVisiblePartTimes [
	^days sum: [ :day | day visiblePartTimes size ]
]

{ #category : #accessing }
GeoOPCollectionMonth >> year [
	^monthObject year
]
