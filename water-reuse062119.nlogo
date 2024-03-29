extensions [ nw ]

turtles-own [ age gender ethnicity education race farm-size adopt? primary-water-source importance  ] ;; properties of farmers



to setup
  ca

  ;; random network
  if ( network-structure = "random" ) [
    nw:generate-random turtles links number-of-agents network-density [
      set color white
      set shape "person"
    setxy random-xcor random-ycor
      set adopt? false
    ]
  ]

 ;; small-world

 if ( network-structure = "small-world") [
     let A ( number-of-agents / 4 )
    nw:generate-small-world turtles links A 4 2.0 false [
      set color white
      set shape "person"
    setxy random-xcor random-ycor
      set adopt? false
    ]
  ]

  ;; prefential-attachment
  if network-structure = "preferential-attachment" [
   nw:generate-preferential-attachment turtles links Number-of-agents 1 [
      set shape "person"
    set color white

 ;; separate the turtles spatially
   setxy random-xcor random-ycor

 ;; adoption property needs to be initialized in the setup
set adopt? false

  ]
  ]

  ;; no-network
  if network-structure = "no-network" [
   crt Number-of-agents [
      set shape "person"
    set color white

 ;; separate the turtles spatially
   setxy random-xcor random-ycor

 ;; adoption property needs to be initialized in the setup
set adopt? false

    ]
  ]
  ;; spring layout
        repeat 30 [ layout-spring turtles links 0.2 5 1 ] ;; lays the nodes in a triangle

  ;; age
  ;; a=19-29 (7%)
ask n-of ( 0.07 * number-of-agents ) turtles [
    set age ( one-of ( range 19 29 1 ) )
  ]

  ;; b=30-49 (33%)
  ask n-of ( 0.33 * number-of-agents ) turtles with [ age = 0] [
    set age ( one-of ( range 30 49 1 ) )
  ]

  ;; c=50-69 (53%)
  ask n-of ( 0.53 * number-of-agents ) turtles with [ age = 0] [
    set age ( one-of ( range 50 69 1 ) )
  ]

  ;; d=70-89 (7%)
 ask n-of ( 0.07 * number-of-agents ) turtles with [ age = 0] [
    set age ( one-of ( range 70 89 1 ) )
  ]


  ;; gender
  ;; male (69%)
 ask n-of ( 0.69 * number-of-agents ) turtles [
  set gender "male"
  ]

  ;; woman (31%)
  ask n-of ( 0.31 * number-of-agents ) turtles with [ gender != "male" ] [
  set gender "female"
 ]


;; ethnicity
  ;; Hispanic or Latino (3%)
 ask n-of ( 0.03 * number-of-agents ) turtles [
  set ethnicity "Hispanic-or-Latino"
  ]

  ;; not Hispanic or Latino (97%)
 ask n-of ( 0.97 * number-of-agents ) turtles with [ ethnicity = 0 ] [
  set ethnicity "not-Hispanic-or-Latino"
 ]


;;education
 ;; some-college-or-less (41%)
   ask n-of ( 0.41 * number-of-agents ) turtles [
  set education "some-college-or-less"
  ]

  ;; 2-year-degree (3%)
  ask n-of ( 0.03 * number-of-agents ) turtles with [ education = 0 ] [
  set education "2-year-degree"
  ]

   ;; 4-year-degree (34%)
  ask n-of ( 0.34 * number-of-agents ) turtles with [ education = 0 ] [
  set education "4-year-degree"
  ]

   ;; graduate-or-professional-degree (21%)
  ask n-of ( 0.21 * number-of-agents ) turtles with [ education = 0 ] [
  set education "graduate-or-professional-degree"
  ]

    ;; doctorate (1%)
  ask n-of ( 0.01 * number-of-agents ) turtles with [ education = 0 ] [
  set education "doctorate"
  ]


;; race
 ;; white (85%)
  ask n-of ( 0.85 * number-of-agents ) turtles [
  set race "white"
  ]

  ;; black-african-american (3%)
  ask n-of ( 0.03 * number-of-agents ) turtles with [ race = 0 ] [
  set race "black-african-american"
  ]

   ;; other (1%)
  ask n-of ( 0.01 * number-of-agents ) turtles with [ race = 0 ] [
  set race "other"
  ]

  ;; prefer-not-to-answer (11%)
   ask n-of ( 0.11 * number-of-agents ) turtles with [ race = 0 ] [
  set race "prefer-not-to-answer"
  ]



;; farm-size
  ;; 0-100 (63%)
   ask n-of ( 0.63 * number-of-agents ) turtles [
  set farm-size "0-100"
  ]

 ;; 101-1000 (32%)
  ask n-of ( 0.32 * number-of-agents ) turtles with [ farm-size = 0 ] [
  set farm-size "101-1000"
  ]

   ;; 1001-over2000 (5%)
  ask n-of ( 0.05 * number-of-agents ) turtles with [ farm-size = 0 ] [
  set farm-size "1001-over2000"
  ]


;; primary-water-source
  ;; surface water (30%)
  ask n-of ( 0.3 * number-of-agents ) turtles [
  set primary-water-source "surface-water"
  ]
;; ground water (60%)
  ask n-of ( 0.6 * number-of-agents ) turtles with [ primary-water-source = 0 ] [
  set primary-water-source "ground-water"
  ]
;; other (10%)
  ask n-of ( 0.1 * number-of-agents ) turtles with [ primary-water-source = 0 ] [
  set primary-water-source "other"
  ]

;; importance
  ;; very-important (23%)
  ask n-of ( 0.23 * number-of-agents ) turtles [
  set importance "very-important"
  ]
  ;; moderately-important (45%)
  ask n-of ( 0.45 * number-of-agents ) turtles with [ importance = 0 ] [
  set importance "moderately-important"
  ]
  ;; not-important (32%)
  ask n-of ( 0.32 * number-of-agents ) turtles with [ importance = 0 ] [
  set importance "not-important"
  ]







  reset-ticks
end



to go

 ;; count the turtles that have not adopted yet
  ifelse count turtles with [ not adopt?] > 0
  [
  ;; ask the turtles to adopt or not adopt randomly
  ask turtles with [ not adopt?]
    [
    adopt
    ]
  ]
    [
      stop
    ]
  tick

end


;; describe the function of adopt
to adopt

  ;; effect of primary water source
  if primary-water-source = "ground-water" and random-float 10.0 < 1.0 [
    set adopt? true
  ]

  if primary-water-source = "surface-water" and random-float 10.0 < 3.05 [
    set adopt? true
  ]

  if primary-water-source = "other" and random-float 10.0 < 0.68 [
    set adopt? true
  ]


 ;; effect of importance
    if importance = "very-important" and random-float 100 < 22.79 [
    set adopt? true
  ]

    if importance = "moderately-important" and random-float 100 < 7.42 [
    set adopt? true
  ]

    if importance = "not-important" and random-float 100 < 1.0 [
    set adopt? true
  ]


;; effect of race
  if race = "white" and random-float 10.0 < 1.0 [
    set adopt? true
  ]

  if race = "black-african-american" and random-float 10.0 < 0.05 [
    set adopt? true
  ]

  if race = "other" and random-float 10.0 < 0.05 [
    set adopt? true
  ]


;; effect of gender
    if gender = "female" and random-float 10.0 < 1.0 [
    set adopt? true
  ]

  if gender = "male" and random-float 10.0 < 0.14 [
    set adopt? true
  ]

  ask turtles with [ adopt? = true ] [
    set color red
  ]



end






to reset-diffusion
  ask turtles [
    set adopt? false
    set color white
  ]
  clear-all-plots
end
@#$#@#$#@
GRAPHICS-WINDOW
961
10
1313
363
-1
-1
10.424242424242424
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
5
78
68
111
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
73
79
136
112
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
296
10
477
55
network-structure
network-structure
"random" "small-world" "preferential-attachment" "no-network"
3

SLIDER
8
10
151
43
number-of-agents
number-of-agents
10
1000
180.0
2
1
NIL
HORIZONTAL

SLIDER
173
10
290
43
network-density
network-density
0
1.0
0.1
0.1
1
NIL
HORIZONTAL

PLOT
6
358
337
567
adoption
time
adoption
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"adopted agents" 1.0 0 -15040220 true "" "plot count turtles with [ adopt? = true ]"
"total agents" 1.0 0 -16777216 true "" "plot number-of-agents"
"not-adopted agents" 1.0 0 -5298144 true "" "plot count turtles with [ adopt? = false ]"

BUTTON
148
80
260
113
reset-diffusion
reset-diffusion
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
433
387
533
432
female adopted
count turtles with [ gender = \"female\" and adopt? = true ]
17
1
11

BUTTON
74
116
137
149
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
86
165
171
210
total females
count turtles with [ gender = \"female\" ]
17
1
11

MONITOR
88
213
155
258
total male
count turtles with [ gender = \"male\" ]
17
1
11

MONITOR
3
164
82
209
age (18-29)
count turtles with [ age = 18 or age = 19 or age = 20 or age = 21 or age = 22 or age = 23 or age = 24 or age = 25 or age = 26 or age = 27 or age = 28 or age = 29]
17
1
11

MONITOR
3
212
82
257
age (30-49)
count turtles with [ age = 30 or age = 31 or age = 32 or age = 33 or age = 34 or age = 35 or age = 36 or age = 37 or age = 38 or age = 39 or age = 40 or age = 41 or age = 42 or age = 43 or age = 44 or age = 45 or age = 46 or age = 47 or age = 48 or age = 49]
17
1
11

MONITOR
3
260
82
305
age (50-69)
count turtles with [ age = 50 or age = 51 or age = 52 or age = 53 or age = 54 or age = 55 or age = 56 or age = 57 or age = 58 or age = 59 or age = 60 or age = 61 or age = 62 or age = 63 or age = 64 or age = 65 or age = 66 or age = 67 or age = 68 or age = 69]
17
1
11

MONITOR
2
308
81
353
age (79-89)
count turtles with [ age = 70 or age = 71 or age = 72 or age = 73 or age = 74 or age = 75 or age = 76 or age = 77 or age = 78 or age = 79 or age = 80 or age = 81 or age = 82 or age = 83 or age = 84 or age = 85 or age = 86 or age = 87 or age = 88 or age = 89]
17
1
11

MONITOR
176
164
295
209
Hispanic-or-Latino
count turtles with [ ethnicity = \"Hispanic-or-Latino\" ]
17
1
11

MONITOR
176
214
294
259
not-Hispanic-or-Latino
count turtles with [ ethnicity = \"not-Hispanic-or-Latino\" ]
17
1
11

MONITOR
301
80
427
125
some-college-or-less
count turtles with [ education = \"some-college-or-less\" ]
17
1
11

MONITOR
302
129
396
174
2-year-degree
count turtles with [ education = \"2-year-degree\" ]
17
1
11

MONITOR
302
178
396
223
4-year-degree
count turtles with [ education = \"4-year-degree\" ]
17
1
11

MONITOR
303
229
505
274
graduate-or-professional-degree
count turtles with [ education = \"graduate-or-professional-degree\" ]
17
1
11

MONITOR
304
278
371
323
doctorate
count turtles with [ education = \"doctorate\" ]
17
1
11

MONITOR
507
160
564
205
white
count turtles with [ race = \"white\" ]
17
1
11

MONITOR
507
210
645
255
black-african-american
count turtles with [ race = \"black-african-american\" ]
17
1
11

MONITOR
508
261
565
306
other
count turtles with [ race = \"other\" ]
17
1
11

MONITOR
509
312
641
357
prefer-not-to-answer
count turtles with [ race = \"prefer-not-to-answer\" ]
17
1
11

MONITOR
648
162
757
207
farm-size (0-100)
count turtles with [ farm-size = \"0-100\" ]
17
1
11

MONITOR
649
210
778
255
farm-size (101-1000)
count turtles with [ farm-size = \"101-1000\" ]
17
1
11

MONITOR
650
260
812
305
farm-size (1001-over2000)
count turtles with [ farm-size = \"1001-over2000\" ]
17
1
11

MONITOR
341
519
431
564
total adoption
count turtles with [ adopt? = true ]
17
1
11

MONITOR
434
436
522
481
male adopted
count turtles with [ gender = \"male\" and adopt? = true ]
17
1
11

MONITOR
552
387
638
432
white adopted
count turtles with [ race = \"white\" and adopt? = true ]
17
1
11

MONITOR
552
437
739
482
black-african-american adopted
count turtles with [ race = \"black-african-american\" and adopt? = true ]
17
1
11

MONITOR
553
486
646
531
other adopted
count turtles with [ race = \"other\" or race = \"prefer-not-to-answer\" and adopt? = true ]
17
1
11

MONITOR
751
388
890
433
not-important adopted
count turtles with [ importance = \"not-important\" and adopt? = true ]
17
1
11

MONITOR
752
439
934
484
moderately-important adopted
count turtles with [ importance = \"moderately-important\" and adopt? = true ]
17
1
11

MONITOR
753
489
899
534
very-important adopted
count turtles with [ importance = \"very-important\" and adopt? = true ]
17
1
11

MONITOR
952
388
1091
433
ground-water adopted
count turtles with [ primary-water-source = \"ground-water\" and adopt? = true ]
17
1
11

MONITOR
953
438
1094
483
surface-water adopted
count turtles with [ primary-water-source = \"surface-water\" and adopt? = true ]
17
1
11

MONITOR
953
487
1046
532
other adopted
count turtles with [ primary-water-source = \"other\" and adopt? = true ]
17
1
11

MONITOR
342
470
432
515
total adopted %
( ( count turtles with [ adopt? = true ] ) / number-of-agents ) * 100
3
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
