Class {
	#name : #GeoOPCollectionDayConverter,
	#superclass : #Object,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #examples }
GeoOPCollectionDayConverter class >> example [

	| strFromExcel |
	strFromExcel := '1/20/2018	morning	Ten Oosten van het Lint (Ochtend)	5	no
1/20/2018	afternoon	Ten Oosten van het Lint (Middag)	2	no
1/27/2018	morning	Ten Westen van het Lint (Ochtend)	2	no'.
				
		self fromString: strFromExcel
]

{ #category : #examples }
GeoOPCollectionDayConverter class >> example2018 [

	| strFromExcel |
	strFromExcel := 
'1/27/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
2/24/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
3/24/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
4/28/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
5/26/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
6/23/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
7/28/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
9/22/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
10/27/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
11/24/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
12/22/2018	morning	Ten Westen van het Lint (Ochtend) Luijendijk	2	no
1/20/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
1/20/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
2/17/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
2/17/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
3/17/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
3/17/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
4/21/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
4/21/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
5/19/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
5/19/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
6/16/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
6/16/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
7/21/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
7/21/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
9/15/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
9/15/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
10/20/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
10/20/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
11/17/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
11/17/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
12/15/2018	morning	Ten Oosten van het Lint (Ochtend) Oude Dorp	5	no
12/15/2018	afternoon	Ten Oosten van het Lint (Middag) Havezathe	2	no
'.
				
		self fromString: strFromExcel
]

{ #category : #converting }
GeoOPCollectionDayConverter class >> fromString: aString [
	| ws now separator lines |
	ws := WriteStream on: String new.
	now := DateAndTime now asSeconds asString.
	separator := $;.
	lines := aString substrings: Character cr asString.
	lines
		do: [ :line | 
			| subStrings dateString needCarString |
			subStrings := line substrings: (Character tab asString).
			dateString := (Date fromString: (subStrings at: 1)) julianDayNumber asString.
			needCarString := (subStrings fifth = 'yes') asString.
			ws
				nextPutAll: now;
				nextPut: separator;
				nextPutAll: 'AddCollectionPartTime';
				nextPut: separator;
				nextPutAll: subStrings second;
				nextPut: separator;
				nextPutAll: dateString;
				nextPut: separator;
				nextPutAll: subStrings third;
				nextPut: separator;
				nextPutAll: (subStrings at: 4) asString;
				nextPut: separator;
				nextPutAll: needCarString;
				nextPut: $% ].
	ws contents inspect
]
