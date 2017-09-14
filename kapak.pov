#declare CoverThickness = 0.004;
#declare PaperInset = 0.0001;
#declare BX = 1 * BookAspect;
#declare BY = 1;

#declare PaperPigment = pigment {
	gradient <0,1,0>
	color_map {
		[0.0 color rgb<0.59,0.57,0.55>]
		[0.5 color rgb<0.59,0.57,0.55>]
		[0.5 color rgb<0.79,0.76,0.73>]
		[0.5 color rgb<0.79,0.76,0.73>]
	}
	scale <0.003,0.003,0.003>
	rotate <90,0,0>
}

#declare BookFinish = finish {
	ambient 0.90
	diffuse 0.5
	reflection 0.05
	specular 0.25
	roughness 0.05
}

background { color rgb<1,1,1> }

camera {
	location <-1,1.50,1.2*ViewZ>
  up y
	right x*OutputAspect
	angle 35
	look_at <.4*BookAspect,0.60,HalfThick>
}

plane
{
	y, 0
	pigment {
		color rgb< 0.6, 0.6, 0.6 >
	}
	finish {
		// reflection 0.05
		// emission rgb< 0.2, 0.2, 0.2 >
		ambient 0.9
	}
}

light_source {
	<-0.2,8,3.0*ViewZ>
	color rgb<1,1,1>
	area_light <0.4, 0, 0>, <0, 0, 0.4>, Lights, Lights
	circular
}

light_source {
	<-3,0,-HalfThick>
	color rgb<0.5,0.5,0.5>
}

#macro Book (ThisBook)

#include ThisBook

#declare BZ = BookThickness;

// front cover
box { <0,0,0> <1,1,CoverThickness>
	pigment {
		image_map {
			png FrontImg
			map_type 0
			interpolate 2
		}
	}
	scale <BookAspect,1,1>
	finish { BookFinish }
}

// back cover
box {
	<0,0,0> <1,1,CoverThickness>
	pigment {
		image_map {
			png BackImg
			map_type 0
			interpolate 2
		}
		rotate <0,180,0>
	}
	scale <BookAspect,1,1>
	finish { BookFinish }
	translate <0,0,BZ-CoverThickness>
}

// spine
difference {
	cylinder { <0,0,0>,<0,1,0>,(BZ/2)
		pigment {
			image_map {
				png SpineImg
				map_type 2
				interpolate 2
			}
		}
		scale <0.1,1,1>
		translate <0,0,(BZ/2)>
		finish { BookFinish }
	}
	box {
		<0,-0.001,0> <1,1.001,BZ>
	}
}

// dimensions of pages
#declare Paper = object {
	box {
		<0,0,0> <1,1,BZ-(CoverThickness*2)>
		scale <BookAspect,1,1>
		translate <0,0,CoverThickness>
	}
}

// pages box with inset
box { min_extent(Paper) max_extent(Paper)-((PaperInset*2)*y)-(PaperInset*x)
	translate <0,PaperInset,0>
	pigment {PaperPigment}
	finish {ambient 0.5}
}

#end

#macro BookFlip (ThisBook)

union {
	Book(ThisBook)
	rotate <0,180,0>
	translate <BX,0,BZ>
}

#end

Scene()
