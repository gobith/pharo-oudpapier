Class {
	#name : #GeoOudpapierSession,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'schedule'
	],
	#category : #'Geo Oudpapier Server'
}

{ #category : #initialization }
GeoOudpapierSession >> addRoutes [

	teapot
		GET: '/users' -> [ :request | schedule sortedUsers ];
		GET: '/years' -> [ :request | schedule reversedCollectionYears ];
		GET: '/current-year' -> [ :request | schedule currentCollectionYear ]
]

{ #category : #initialization }
GeoOudpapierSession >> initialize [ 

	super initialize .
	
]

{ #category : #initialization }
GeoOudpapierSession >> portNumber [
	^ 8090
]

{ #category : #initialization }
GeoOudpapierSession >> start [

	self stop.
	
	schedule := GeoOPCollectionSchedule new.
	schedule fileIn.
	schedule setAdminUser.
	schedule createCollectionMonths.
	
	teapot := Teapot configure: {(#port -> self portNumber) . #defaultOutput -> #json . #debugMode -> true}.

	self addRoutes.
	teapot start
]

{ #category : #initialization }
GeoOudpapierSession >> stop [ 
	
	teapot ifNotNil: [ teapot stop ].
	teapot := nil.
	schedule := nil
]
