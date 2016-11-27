%====INFORMATION====%
% LFSAB1402 Projet 2016
% Nomas : 08891500-54931500
% Noms : (Charlier,Gilles)-(Fiset,Alexandre)
%====MODULELINK====%
declare
[Projet]={Module.link ["/home/gilles/SugarPicker/Projet2016.ozf"]}
{Property.put 'MyDir' '/home/gilles/SugarPicker/'}
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
		    withCheckMapEasy:false
		    withCheckMapComplete:false
		   )
in
   Map = map(ru:[scale(rx:100.0 ry:100.0 1:[translate(dx:200.0 dy:200.0 1:[primitive(kind:road)])])] pu:[translate(dx:200.0 dy:mult(time 50.0) 1:[spawn(tmin:5 tmax:6 1:[spawn(tmin:3 tmax:6 1:[primitive(kind:pokemon)])])])]) %% TODO change the map here
% Prends une liste de Ru en paramètre
% Si le record traité est une primitive, alors le record est traité avec ses opérations précédentes dans le bon ordre, et est joint à la suite des autres records.
% Sinon, selon le record traité, effectue des opérations correspondantes sur les coordonnées de la future primitive traitée. -- OK
   
   fun{MyFunction Map}
      local Determine Create Separate Reorganise BuildFunc Calculate in 
	 % Lance la fonction Determine sur la liste Ru et Pu de la map. -- OK
	 fun{Separate Map}
	    case Map of nil then nil
	    [] map(ru:Ru pu:Pu) then
	       local I1 I2 in
		  I1={Determine Ru 0.0 0.0 0.0 1.0 1.0 1.0 1.0 0.0 0 MaxTime}
		  I2={Determine Pu 0.0 0.0 0.0 1.0 1.0 1.0 1.0 0.0 0 MaxTime}
		  {Append {Reorganise I1} {Reorganise I2}}
	       end
	    end
	 end
	 fun{Create Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 K Times LapsMin LapsMax}
	    if {Float.toInt Times} < LapsMin orelse {Float.toInt Times} >= LapsMax then empty
	    else
	       
	       case K of road then realitem(kind:road
					    p1:pt(x:{Calculate Dx1 Times} y:{Calculate Dy1 Times})
					    p2:pt(x:{Calculate Dx4 Times} y:{Calculate Dy4 Times}))
	       [] building then realitem(kind:building
					 p1:pt(x:{Calculate Dx1 Times} y:{Calculate Dy1 Times})
					 p2:pt(x:{Calculate Dx2 Times} y:{Calculate Dy2 Times})
					 p3:pt(x:{Calculate Dx3 Times} y:{Calculate Dy3 Times})
					 p4:pt(x:{Calculate Dx4 Times} y:{Calculate Dy4 Times})
					)
	       [] water then  realitem(kind:water
				       p1:pt(x:{Calculate Dx1 Times} y:{Calculate Dy1 Times})
				       p2:pt(x:{Calculate Dx2 Times} y:{Calculate Dy2 Times})
				       p3:pt(x:{Calculate Dx3 Times} y:{Calculate Dy3 Times})
				       p4:pt(x:{Calculate Dx4 Times} y:{Calculate Dy4 Times})
				      )
	       [] pokemon then pokeitem(kind:pokemon  position:pt(x:{Calculate Dx1 Times} y:{Calculate Dy1 Times}))
	       [] pokestop then pokeitem(kind:pokestop position:pt(x:{Calculate Dx1 Times} y:{Calculate Dy1 Times}))
	       [] arena then pokeitem(kind:arena position:pt(x:{Calculate Dx1 Times} y:{Calculate Dy1 Times}))
	       else nil
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
	 fun{BuildFunc Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 K LapsMin LapsMax}
	    fun{$ Times} {Create Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 K Times LapsMin LapsMax}  end
	 end
	 
	 fun{Determine Ru Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 LapsMin LapsMax}
	    case Ru of H|T then
	       case H of primitive(kind:K) then
		  {BuildFunc Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 K LapsMin LapsMax}
		  |{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 LapsMin LapsMax}
	       [] translate(dx:X dy:Y 1:RU) then
		  {Determine RU plus(Dx1 X) plus(Dy1 Y) plus(Dx2 X) plus(Dy2 Y) plus(Dx3 X) plus(Dy3 Y) plus(Dx4 X) plus(Dy4 Y) LapsMin LapsMax}
		  |{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 LapsMin LapsMax}
	       [] scale(rx:X ry:Y 1:RU) then
		  {Determine RU mult(Dx1 X) mult(Dy1 Y) mult(Dx2 X) mult(Dy2 Y) mult(Dx3 X) mult(Dy3 Y) mult(Dx4 X) mult(Dy4 Y) LapsMin LapsMax}
		  |{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 LapsMin LapsMax}
	       [] rotate(angle:Theta 1:RU) then
		  {Determine RU
		   plus(mult(Dx1 cos(Theta)) mult(Dy1 sin(Theta))) minus(mult(Dy1 cos(Theta)) mult(Dx1 sin(Theta)))
		   plus(mult(Dx2 cos(Theta)) mult(Dy2 sin(Theta))) minus(mult(Dy2 cos(Theta)) mult(Dx2 sin(Theta)))
		   plus(mult(Dx3 cos(Theta)) mult(Dy3 sin(Theta))) minus(mult(Dy3 cos(Theta)) mult(Dx3 sin(Theta)))
		   plus(mult(Dx4 cos(Theta)) mult(Dy4 sin(Theta))) minus(mult(Dy4 cos(Theta)) mult(Dx4 sin(Theta)))
		   LapsMin LapsMax}
		  |{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 LapsMin LapsMax}
	       [] spawn(tmin:MinTime1 tmax:MaxTime1 1:RU) then
		  if MinTime1 > LapsMin andthen MaxTime1 < LapsMax then
		     {Determine RU Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 MinTime1 MaxTime1}|{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 0 MaxTime} % nouvelle intervalle avec deux nouvelles bornes
		  elseif MinTime1 > LapsMin then
		     {Determine RU Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 MinTime1 LapsMax}|{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 0 MaxTime} % Juste la borne inférieure change
		  elseif MaxTime1 < LapsMax then
		     {Determine RU Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 LapsMin MaxTime1}|{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 0 MaxTime} % Juste la borne inférieure change
		  else
		     {Determine RU Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 LapsMin LapsMax}|{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 0 MaxTime} % L'intervale exigé est plus grand que l'intervale courant
		  end
		  
	       else nil
	       end
	    else nil
	    end
	 end
% Reorganise lea liste passée en paramètre pour avoir une simple liste de record -- OK
	 fun{Reorganise L}
	    case L of H|T then
	       case H of H1|T1 then
		  {Append {Reorganise H} T}
	       else H|{Reorganise T}
	       end
	    else L
	    end
	 end
	 {Separate Map}
      end
   end
   
   
   fun{CheckMap Map}
      false
   end
   {Projet.run MyFunction Map MaxTime Extensions CheckMap}
end
