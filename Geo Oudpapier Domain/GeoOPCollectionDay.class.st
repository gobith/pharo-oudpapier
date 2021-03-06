Class {
	#name : #GeoOPCollectionDay,
	#superclass : #Object,
	#instVars : [
		'date',
		'month',
		'partTimes',
		'schedule'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPCollectionDay class >> dayNames [

	^ {'Zondag' . 'Maandag' . 'Dinsdag' . 'Woensdag' . 'Donderdag' . 'Vrijdag' . 'Zaterdag'}
]

{ #category : #accessing }
GeoOPCollectionDay class >> neoJsonMappingOn: mapping [

	"date month partTimes"

	mapping
		mapAccessor: #dateString to: #date;
		mapAccessor: #dayOfMonth;
		mapAccessor: #dayName;
		mapInstVar: #partTimes
]

{ #category : #accessing }
GeoOPCollectionDay >> date [
	^ date
]

{ #category : #accessing }
GeoOPCollectionDay >> date: anObject [
	date := anObject
]

{ #category : #accessing }
GeoOPCollectionDay >> dateString [ 
	^date yyyymmdd 
]

{ #category : #accessing }
GeoOPCollectionDay >> dayName [
	^self class dayNames at: date weekdayIndex
]

{ #category : #accessing }
GeoOPCollectionDay >> dayOfMonth [

	^date dayOfMonth 
]

{ #category : #initialization }
GeoOPCollectionDay >> initialize [

	super initialize.
	partTimes := OrderedCollection new
]

{ #category : #accessing }
GeoOPCollectionDay >> month [
	^ month
]

{ #category : #accessing }
GeoOPCollectionDay >> month: anObject [
	month := anObject
]

{ #category : #accessing }
GeoOPCollectionDay >> monthName [
	^month longMonthName
]

{ #category : #accessing }
GeoOPCollectionDay >> partTimes [
	^ partTimes
]

{ #category : #accessing }
GeoOPCollectionDay >> partTimes: anObject [
	partTimes := anObject
]

{ #category : #accessing }
GeoOPCollectionDay >> schedule [

	^ schedule
]

{ #category : #accessing }
GeoOPCollectionDay >> schedule: anObject [

	schedule := anObject
]

{ #category : #accessing }
GeoOPCollectionDay >> visiblePartTimes [

	^self partTimes select: [ : partTime | partTime isVisible ]
]
