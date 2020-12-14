reset
create cylinder radius 2.5 height 5.0
volume 1 move z 2.5
create cylinder radius 2.45 height 4.95
volume 2 move z 2.45
subtract volume 2 from volume 1
create cylinder radius 2.45 height 4
volume 3 move z 2.0
merge all
webcut volume 1  with sheet extended from surface 10
webcut volume 1  with sheet extended from surface 12
merge all

create sphere radius 3.625 inner radius 3.575 znegative
create sphere radius 3.575 znegative
webcut volume 6 with general plane zplane offset -2.625
webcut volume 7 with general plane zplane offset -2.625
delete volume 6 7
volume 8 move z 2.625
volume 9 move z 2.625

create cylinder height 8.3 radius 1.5
webcut volume 8 with sheet extended from surface 37
webcut volume 9 with sheet extended from surface 37
webcut volume 3 with sheet extended from surface 37
delete volume 10
webcut volume 8 with plane xplane rotate 45 about z
webcut volume 9 with plane xplane rotate 45 about z
webcut volume 3 with plane xplane rotate 45 about z
merge all

webcut volume 1  with sheet extended from surface 8
merge all
webcut volume 5 with plane xplane rotate 45 about z
webcut volume 17 with plane xplane rotate 45 about z
webcut volume 1 with plane xplane rotate 45 about z
webcut volume 4 with plane xplane rotate 45 about z
merge all
merge surface 67 with surface 109 force
merge surface 62 with surface 100 force
merge surface 72 with surface 82 force
merge surface 91 with surface 79 force
merge all
webcut volume 11 with plane xplane rotate 45 about z
webcut volume 12 with plane xplane rotate 45 about z
webcut volume 13 with plane xplane rotate 45 about z
merge all

create cylinder height 0.15 radius 2.45
volume 25 move z 5.05625
webcut volume 25 with plane xplane rotate 45 about z
merge surface 174 with surface 141 force
merge surface 172 with surface 135 force

create cylinder height 0.15 radius 3.75
webcut volume 27 with plane xplane rotate 45 about z
volume 27 move z 3.0
volume 28 move z 3.0
webcut volume 28  with sheet extended from surface 89
webcut volume 27  with sheet extended from surface 84
volume 27 move z 2.05625
volume 28 move z 2.05625
merge surface 175 with surface 188 force
merge surface 171 with surface 197 force
merge surface 200 with surface 191 force
merge surface 199 with surface 190 force
merge all

delete volume 29 30

create vertex 0.0 -3.10 4.98125 on surface 189
create vertex 0.0 -3.5 4.98125 on surface 189
create vertex 0.0 -2.7 4.98125 on surface 189
create vertex 0.4 -3.1 4.98125 on surface 189
create vertex -0.4 -3.1 4.98125 on surface 189
create vertex 0.0 3.10 4.98125 on surface 201
create vertex 0.0 3.5 4.98125 on surface 201
create vertex 0.0 2.7 4.98125 on surface 201
create vertex 0.4 3.1 4.98125 on surface 201
create vertex -0.4 3.1 4.98125 on surface 201
create vertex -3.1 0.0 4.98125 on surface 189
create vertex -3.5 0.0 4.98125 on surface 189
create vertex -2.7 0.0 4.98125 on surface 189
create vertex -3.1 0.4 4.98125 on surface 189
create vertex -3.1 -0.4 4.98125 on surface 189
create vertex 3.1 0.0 4.98125 on surface 201
create vertex 3.5 0.0 4.98125 on surface 201
create vertex 2.7 0.0 4.98125 on surface 201
create vertex 3.1 0.4 4.98125 on surface 201
create vertex 3.1 -0.4 4.98125 on surface 201

imprint volume 28 with vertex 202 203 204 205 206 212 213 214 215 216
imprint volume 27 with vertex 207 208 209 210 211 217 218 219 220 221
delete vertex 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221

create vertex 0.0 -3.10 4.66125
create vertex 0.0 3.10 4.66125
create vertex -3.1 0.037 4.66125
create vertex 3.1 0.0 4.66125

create curve vertex 227 231
create curve vertex 228 231
create curve vertex 229 231
create curve vertex 230 231
create curve vertex 242 231

create curve vertex 225 226
create curve vertex 222 226
create curve vertex 224 226
create curve vertex 223 226
create curve vertex 244 226

create curve vertex 234 236
create curve vertex 232 236
create curve vertex 235 236
create curve vertex 233 236
create curve vertex 245 236

create curve vertex 240 241
create curve vertex 239 241
create curve vertex 238 241
create curve vertex 237 241
create curve vertex 243 241

merge all

surface 61 scheme hole rad_intervals 3
mesh surface 61

volume 11 size auto factor 10
mesh volume 11
volume 22 size auto factor 10
mesh volume 22
mesh volume 14
mesh volume 8
volume 18 int 10
mesh volume 18
volume 5 int 10
mesh volume 5
mesh volume 19
mesh volume 17
mesh volume 20
mesh volume 1
mesh volume 21
mesh volume 4
mesh volume 15
mesh volume 9
mesh volume 12
mesh volume 23
mesh volume 3
mesh volume 16
mesh volume 13
mesh volume 24
mesh volume 25
mesh volume 26
mesh volume 27
mesh volume 28

curve 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 interval 1
curve 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 scheme equal
mesh curve 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323

merge all

block 1 add volume 21 4 17 19 18 5 8 14 11 22 1 20
block 2 add volume 9 15 12 23 16 3 24 13
block 3 add volume 25 26 27 28
block 4 add curve 308 318 323 313
block 5 add curve 304 305 306 307 309 310 311 312 314 315 316 317 319 320 321 322

sideset 5 add surface 88 85 165 159
sideset 5 name "Fluid_top"

nodeset 6 add vertex 244 242 245 243
nodeset 6 name "IsoBottom"

nodeset 7 add vertex 226 231 241 236
nodeset 7 name "IsoTop"
