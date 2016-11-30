%====INFORMATION====%
% LFSAB1402 Projet 2016
% Nomas : 08891500-54931500
% Noms : (Charlier,Gilles)-(Fiset,Alexandre)
%====MODULELINK====%
declare
[Projet]={Module.link ["/home/alexandre/Bureau/info2_projet/Projet2016.ozf"]}
{Property.put 'MyDir' '/home/alexandre/Bureau/info2_projet/'}
%====CODE====%
local
   MaxTime = 10 % nombre de frame à l'animation
   MyFunction
   Map
   CheckMap
   Extensions = opt(withExtendedFormula:true
		    withIfThenElse:true
		    withComparison:true
		    withTimeWindow:true
		    withCheckMapEasy:true
		    withCheckMapComplete:true
		   )      
   RU=[translate(dx:neg(500.0) dy:neg(500.0) 1:[scale(rx:2000.0 ry:2000.0 1:[primitive(kind:water)])])%Background
       translate(dx:0.0 dy:0.0 1:[scale(rx:500.0 ry:15.0 1:[primitive(kind:building)])])
       translate(dx:0.0 dy:485.0 1:[scale(rx:500.0 ry:15.0 1:[primitive(kind:building )])])
       translate(dx:485.0 dy:0.0 1:[scale(rx:15.0 ry:500.0 1:[primitive(kind:building )])])
       translate(dx:0.0 dy:0.0 1:[scale(rx:15.0 ry:500.0 1:[primitive(kind:building )])])
       translate(dx:235.0 dy:15.0 1:[scale(rx:20.0 ry:65.0 1:[primitive(kind:building )])])%39
       translate(dx:46.0 dy:45.0 1:[scale(rx:55.0 ry:32.0 1:[primitive(kind:building )])])%1
       translate(dx:400.0 dy:45.0 1:[scale(rx:55.0 ry:32.0 1:[primitive(kind:building )])])%4
       translate(dx:130.0 dy:45.0 1:[scale(rx:75.0 ry:32.0 1:[primitive(kind:building )])])%2
       translate(dx:292.0 dy:45.0 1:[scale(rx:75.0 ry:32.0 1:[primitive(kind:building )])])%3
       translate(dx:45.0 dy:109.0 1:[scale(rx:55.0 ry:16.0 1:[primitive(kind:building )])])%5
       translate(dx:135.0 dy:107.0 1:[scale(rx:18.0 ry:112.0 1:[primitive(kind:building)])])%6
       translate(dx:135.0 dy:153.0 1:[scale(rx:72.0 ry:16.0 1:[primitive(kind:building)])])%7
       translate(dx:187.0 dy:107.0 1:[scale(rx:126.0 ry:16.0 1:[primitive(kind:building)])])%8
       translate(dx:239.0 dy:107.0 1:[scale(rx:18.0 ry:65.0 1:[primitive(kind:building)])])%9
       translate(dx:347.0 dy:107.0 1:[scale(rx:18.0 ry:112.0 1:[primitive(kind:building)])])%10
       translate(dx:292.0 dy:155.0 1:[scale(rx:55.0 ry:16.0 1:[primitive(kind:building)])])%11
       translate(dx:395.0 dy:155.0 1:[scale(rx:90.0 ry:64.0 1:[primitive(kind:building)])])%12
       translate(dx:400.0 dy:107.0 1:[scale(rx:55.0 ry:16.0 1:[primitive(kind:building)])])%13
       translate(dx:395.0 dy:251.0 1:[scale(rx:90.0 ry:64.0 1:[primitive(kind:building)])])%14
       translate(dx:347.0 dy:251.0 1:[scale(rx:18.0 ry:64.0 1:[primitive(kind:building)])])%15
       translate(dx:187.0 dy:297.0 1:[scale(rx:126.0 ry:16.0 1:[primitive(kind:building)])])%16
       translate(dx:239.0 dy:297.0 1:[scale(rx:18.0 ry:64.0 1:[primitive(kind:building)])])%17
       translate(dx:187.0 dy:258.0 1:[scale(rx:126.0 ry:10.0 1:[primitive(kind:building)])])%18
       translate(dx:187.0 dy:203.0 1:[scale(rx:10.0 ry:64.0 1:[primitive(kind:building)])])%19
       translate(dx:187.0 dy:203.0 1:[scale(rx:36.0 ry:10.0 1:[primitive(kind:building)])])%20
       translate(dx:271.0 dy:203.0 1:[scale(rx:36.0 ry:10.0 1:[primitive(kind:building)])])%21
       translate(dx:302.0 dy:203.0 1:[scale(rx:10.0 ry:64.0 1:[primitive(kind:building)])])%22
       translate(dx:135.0 dy:251.0 1:[scale(rx:18.0 ry:64.0 1:[primitive(kind:building)])])%23
       translate(dx:15.0 dy:155.0 1:[scale(rx:90.0 ry:64.0 1:[primitive(kind:building)])])%24
       translate(dx:15.0 dy:251.0 1:[scale(rx:90.0 ry:64.0 1:[primitive(kind:building)])])%25
       translate(dx:46.0 dy:345.0 1:[scale(rx:54.0 ry:16.0 1:[primitive(kind:building)])])%26
       translate(dx:81.0 dy:345.0 1:[scale(rx:18.0 ry:64.0 1:[primitive(kind:building)])])%27
       translate(dx:135.0 dy:394.0 1:[scale(rx:18.0 ry:64.0 1:[primitive(kind:building)])])%28
       translate(dx:46.0 dy:441.0 1:[scale(rx:162.0 ry:16.0 1:[primitive(kind:building)])])%29
       translate(dx:135.0 dy:345.0 1:[scale(rx:72.0 ry:16.0 1:[primitive(kind:building)])])%30
       translate(dx:15.0 dy:392.0 1:[scale(rx:36.0 ry:16.0 1:[primitive(kind:building)])])%31
       translate(dx:187.0 dy:395.0 1:[scale(rx:126.0 ry:16.0 1:[primitive(kind:building)])])%32
       translate(dx:239.0 dy:395.0 1:[scale(rx:18.0 ry:64.0 1:[primitive(kind:building)])])%33
       translate(dx:347.0 dy:392.0 1:[scale(rx:18.0 ry:64.0 1:[primitive(kind:building)])])%34
       translate(dx:293.0 dy:441.0 1:[scale(rx:162.0 ry:16.0 1:[primitive(kind:building)])])%35
       translate(dx:293.0 dy:345.0 1:[scale(rx:72.0 ry:16.0 1:[primitive(kind:building)])])%36
       translate(dx:400.0 dy:345.0 1:[scale(rx:18.0 ry:64.0 1:[primitive(kind:building)])])%37
       translate(dx:449.0 dy:393.0 1:[scale(rx:36.0 ry:16.0 1:[primitive(kind:building)])])%38
       translate(dx:400.0 dy:345.0 1:[scale(rx:54.0 ry:16.0 1:[primitive(kind:building)])])%39
       translate(dx:225.0 dy:207.0 1:[scale(rx:46.0 ry:1.0 1:[primitive(kind:road)])])%40
       
	     
	     
	     
	    
	     
	    
	     
      ]
   PU=[translate(dx:248.0 dy:376.0 1:[spawn(tmin:0 tmax:5 1:[translate(dx:mult(18.0 neg(time)) dy:0.0 1:[ primitive(kind:pokemon)])])])%1
       translate(dx:0.0 dy:mult(16.0 minus(time 5.0)) 1:[spawn(tmin:5 tmax:8 1:[translate(dx:176.0 dy:394.0 1:[ primitive(kind:pokemon)])])])%2
     %  translate(dx:mult(18.0 minus(time 8.0) dy:0.0) 1:[spawn(tmin:8 tmax:10 1:[translate(dx:194.0 dy:442.0 1:[ primitive(kind:pokemon)])])])%3
       translate(dx:248.0 dy:189.0 1:[primitive(kind:arena)])
       translate(dx:215.0 dy:235.0 1:[primitive(kind:arena)])
       translate(dx:250.0 dy:235.0 1:[primitive(kind:arena)])
       translate(dx:285.0 dy:235.0 1:[primitive(kind:arena)])
       translate(dx:31.0 dy:30.0 1:[primitive(kind:pokestop)])
       translate(dx:31.0 dy:470.0 1:[primitive(kind:pokestop)])
       translate(dx:469.0 dy:30.0 1:[primitive(kind:pokestop)])
       translate(dx:469.0 dy:470.0 1:[primitive(kind:pokestop)])
      ]
in
   Map=map(ru:RU pu:PU)
  % map(ru:[translate(dx:plus(200.0 50.0) dy:mult(50.0 mult(5.0 cos(0.0))) 1:[scale(rx:100.0 ry:100.0 1:[primitive(kind:road)])]) scale(rx:200.0 ry:200.0 1:[primitive(kind:road) primitive(kind:building)])] pu:nil) %% TODO change the map here
% Prends une liste de Ru en paramètre
% Si le record traité est une primitive, alors le record est traité avec ses opérations précédentes dans le bon ordre, et est joint à la suite des autres records.
% Sinon, selon le record traité, effectue des opérations correspondantes sur les coordonnées de la future primitive traitée. -- OK
   
   fun{MyFunction Map}
      local Determine Create Separate Reorganise BuildFunc Calculate CreateOpp in 
	 % Lance la fonction Determine sur la liste Ru et Pu de la map. -- OK
	 fun{Separate Map}
	    case Map of nil then nil
	    [] map(ru:Ru pu:Pu) then
	       local I1 I2 in
		  I1={Determine Ru nil 0 0}
		  I2={Determine Pu nil 0 MaxTime+1}
		  {Append {Reorganise I1} {Reorganise I2}} 
	       end
	    end
	 end
	 fun{Create Opp K Times LapsMin LapsMax}
	    case K of road then realitem(kind:road
					 p1:pt(x:{CreateOpp Opp x(0.0 0.0) 0.0} y:{CreateOpp Opp y(0.0 0.0) 0.0})
					 p2:pt(x:{CreateOpp Opp x(1.0 0.0) 0.0} y:{CreateOpp Opp y(1.0 0.0) 0.0}))
	    [] building then realitem(kind:building
				      p1:pt(x:{CreateOpp Opp x(0.0 0.0) 0.0} y:{CreateOpp Opp y(0.0 0.0) 0.0})
				      p2:pt(x:{CreateOpp Opp x(0.0 1.0) 0.0} y:{CreateOpp Opp y(0.0 1.0) 0.0})
				      p3:pt(x:{CreateOpp Opp x(1.0 1.0) 0.0} y:{CreateOpp Opp y(1.0 1.0) 0.0})
				      p4:pt(x:{CreateOpp Opp x(1.0 0.0) 0.0} y:{CreateOpp Opp y(1.0 0.0) 0.0})
				     )
	    [] water then  realitem(kind:water
				    p1:pt(x:{CreateOpp Opp x(0.0 0.0) 0.0} y:{CreateOpp Opp y(0.0 0.0) 0.0})
				    p2:pt(x:{CreateOpp Opp x(0.0 1.0) 0.0} y:{CreateOpp Opp y(0.0 1.0) 0.0})
				    p3:pt(x:{CreateOpp Opp x(1.0 1.0) 0.0} y:{CreateOpp Opp y(1.0 1.0) 0.0})
				    p4:pt(x:{CreateOpp Opp x(1.0 0.0) 0.0} y:{CreateOpp Opp y(1.0 0.0) 0.0})
				   )
	    else
	       if {Float.toInt Times} < LapsMin orelse {Float.toInt Times} >= LapsMax then empty
	       else
		  case K of pokemon then pokeitem(kind:pokemon  position:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times}))
		  [] pokestop then pokeitem(kind:pokestop position:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times}))
		  [] arena then pokeitem(kind:arena position:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times}))
		  end
	       end
	    end
	 end
	 fun{CreateOpp Opp Point Times}
	    case Opp of nil then
	       case Point of x(X Y) then {Calculate X Times}
	       [] y(X Y) then {Calculate Y Times}
	       end
	    [] H|T then
	       case H of trans(X Y) then
		  case Point of x(X1 Y1) then
		     {CreateOpp T x(plus(X1 X) plus(Y1 Y)) Times}
		  [] y(X1 Y1) then
		     {CreateOpp T y(plus(X1 X) plus(Y1 Y)) Times}
		  end
	       [] scale(X Y) then
		  case Point of x(X1 Y1) then
		     {CreateOpp T x(mult(X1 X) mult(Y1 Y)) Times}
		  [] y(X1 Y1) then
		     {CreateOpp T y(mult(X1 X) mult(Y1 Y)) Times}
		  end
	       [] rotate(Theta) then
		  case Point of x(X1 Y1) then
		     {CreateOpp T x(plus(mult(X1 cos(Theta)) mult(Y1 sin(Theta))) minus(mult(Y1 cos(Theta)) mult(X1 sin(Theta)))) Times}
		  [] y(X1 Y1) then
		     {CreateOpp T y(plus(mult(X1 cos(Theta)) mult(Y1 sin(Theta))) minus(mult(Y1 cos(Theta)) mult(X1 sin(Theta)))) Times}
		  end
	       end
	    end
	 end
	 fun{Calculate Data Times}
	    case Data of time then Times
	    [] plus(X Y) then
	       {Calculate X Times} + {Calculate Y Times}
	    [] minus(X Y) then
	       {Calculate X Times} - {Calculate Y Times}
	    [] mult(X Y) then
	       {Calculate X Times} * {Calculate Y Times}
	    []'div'(X Y) then
	       {Calculate X Times} / {Calculate Y Times}
	    [] sin(X) then case X of time then {Float.sin Times} else {Float.sin {Calculate X Times}} end
	    [] cos(X) then case X of time then {Float.cos Times} else {Float.cos {Calculate X Times}} end
	    [] tan(X) then case X of time then {Float.tan Times} else {Float.tan {Calculate X Times}} end
	    [] exp(X) then case X of time then {Float.exp Times} else {Float.exp {Calculate X Times}} end
	    [] log(X) then case X of time then {Float.log Times} else {Float.log {Calculate X Times}} end
	    [] neg(X) then ~{Calculate X Times}
	    [] ite(X Y Z) then if {Calculate X Times} == 0.0 then {Calculate Z Times} else {Calculate Y Times} end
	    [] eq(X Y) then if {Calculate X Times} == {Calculate Y Times} then 1.0 else 0.0 end
	    [] ne(X Y) then if {Calculate X Times} == {Calculate Y Times} then 0.0 else 1.0 end
	    [] lt(X Y) then if {Calculate X Times} < {Calculate Y Times} then 1.0 else 0.0 end
	    [] le(X Y) then if {Calculate X Times} =< {Calculate Y Times} then 1.0 else 0.0 end
	    [] gt(X Y) then if {Calculate X Times} > {Calculate Y Times} then 1.0 else 0.0 end
	    [] ge(X Y) then if {Calculate X Times} >= {Calculate Y Times} then 1.0 else 0.0 end 
	    else Data
	    end
	 end
	 fun{BuildFunc Opp K LapsMin LapsMax}
	    fun{$ Times} {Create Opp  K Times LapsMin LapsMax}  end
	 end
	 
	 fun{Determine Ru Opp LapsMin LapsMax}
	    case Ru of H|T then
	       case H of primitive(kind:K) then
		  {BuildFunc Opp K LapsMin LapsMax}
		  |{Determine T Opp LapsMin LapsMax}
	       [] translate(dx:X dy:Y 1:RU) then
		  {Determine RU trans(X Y)|Opp LapsMin LapsMax}
		  |{Determine T Opp LapsMin LapsMax}
	       [] scale(rx:X ry:Y 1:RU) then
		  {Determine RU scale(X Y)|Opp LapsMin LapsMax}
		  |{Determine T Opp LapsMin LapsMax}
	       [] rotate(angle:Theta 1:RU) then
		  {Determine RU rotate(Theta)|Opp LapsMin LapsMax}
		  |{Determine T Opp LapsMin LapsMax}
	       [] spawn(tmin:Min tmax:Max 1:RU) then
		  if Min > LapsMin andthen Max < LapsMax then
		     {Determine RU Opp Min Max}|{Determine T Opp LapsMin LapsMax}
		  elseif Min > LapsMin then
		     {Determine RU Opp Min LapsMax}|{Determine T Opp LapsMin LapsMax}
		  elseif Max < LapsMax then
		     {Determine RU Opp LapsMin Max}|{Determine T Opp LapsMin LapsMax}
		  else
		     {Determine RU Opp LapsMin LapsMax}|{Determine T Opp LapsMin LapsMax}
		  end
		  
	       else nil
	       end
	    else nil
	    end
	 end
	 
% Reorganise lea liste passée en paramètre pour avoir une simple liste de record -- OK
	 fun{Reorganise L}
	    case L of nil then nil
	    [] H|T then
	       case H of H1|T1 then
		  {Append  {Append {Reorganise H1} {Reorganise T1}} {Reorganise T}}
	       else
		  {Append [H] {Reorganise T}}
	       end
	    else
	       [L]
	    end
	 end
	 {Separate Map}
      end
   end
   fun{CheckMap Map}
      local CheckRu CheckPu CheckList CheckFormule in
	 fun{CheckList Rp Case}
	    case Rp of nil then true
	    [] X|Y then
	       if Case==ru then
		  if {CheckRu [X]} then {CheckList Y Case}
		  else false
		  end
	       elseif Case==pu then
		  if {CheckPu [X]} then {CheckList Y Case}
		  else false
		  end
	       else false
	       end
	    else false
	    end
	 end	  
	 fun{CheckRu Ru}
	    case Ru of nil then  true
	    [] X|Y then 
	       case X of primitive(kind:K) then
		  if K== road then {CheckRu Y}
		  elseif K== water then {CheckRu Y}
		  elseif K== building then  {CheckRu Y}
		  else false
		  end
	       [] scale(rx:Rx ry:Ry 1:Ru) then
		  if {CheckFormule Rx false} andthen {CheckFormule Ry false} then {CheckRu Ru}
		  else false
		  end
	       [] translate(dx:Dx dy:Dy 1:Ru ) then
		  if {CheckFormule Dx false} andthen {CheckFormule Dy false} then {CheckRu Ru}
		  else false
		  end
	       [] rotate(angle:Theta 1:Ru) then
		  if {CheckFormule Theta false} then {CheckRu Ru}
		  else false
		  end
	       else false
	       end
	    else false
	    end
	 end
	 
	 fun {CheckPu Pu}
	    case Pu of nil then true
	    [] X|Y then
	       case X of primitive(kind:K) then
		  if K == pokemon then {CheckPu Y}
		  elseif K== pokestop then {CheckPu Y}
		  elseif K==arena then {CheckPu Y}
		  else false
		  end
	       []translate(dx:Dx dy:Dy 1:Pu) then
		  if {CheckFormule Dy true} andthen {CheckFormule Dx true} then {CheckPu Pu}
		  else false
		  end
	       [] spawn(tmin:X tmax:Y 1:Pu) then
		  if {Int.is X} andthen {Int.is Y} then true
		  else false
		  end
	       else false
	       end
	    else false
	    end
	 end
	 fun{CheckFormule F Flag}
	    if {Float.is F} then true
	    else
	       case F of time then
		  if Flag==true then true
		  else false
		  end
	       [] plus(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] minus(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] mult(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] 'div'(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] sin(X) then
		  if {CheckFormule X Flag} then true
		  else false
		  end
	       [] cos(X) then
		  if {CheckFormule X Flag} then true
		  else false
		  end
	       [] tan(X) then
		  if {CheckFormule X Flag} then true
		  else false
		  end
	       [] exp(X) then
		  if {CheckFormule X Flag} then true
		  else false
		  end
	       [] log(X) then
		  if {CheckFormule X Flag} then true
		  else false
		  end
	       [] neg(X) then
		  if {CheckFormule X Flag} then true
		  else false
		  end
	       [] ite(X Y Z) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} andthen {CheckFormule Z Flag} then true
		  else false
		  end
	       [] eq(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] ne(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] lt(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] le(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] gt(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       [] ge(X Y) then
		  if {CheckFormule X Flag} andthen {CheckFormule Y Flag} then true
		  else false
		  end
	       else false
	       end
	    end
	 end
	 case Map of map(ru:Ru pu:Pu) then
	    if {CheckList Ru ru} andthen {CheckList Pu pu} then true
	    else false
	    end
	 else false
	 end
      end
   end
   {Projet.run MyFunction Map MaxTime Extensions CheckMap}
end