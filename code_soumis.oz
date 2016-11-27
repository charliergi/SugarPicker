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
		    withCheckMapEasy:false
		    withCheckMapComplete:false
		   )
in
   Map =map(ru:[translate(dx:100.0 dy:100.0 1:[scale(rx:10.0 ry:10.0 1:[primitive(kind:road)])])] pu:[translate(dx:time dy:250.0 1:[primitive(kind:pokemon)])])
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
	 I1={Determine Ru nil}
	 I2={Determine Pu nil}
	 {Append {Reorganise I1} {Reorganise I2}} 
      end
   end
end
	 fun{Create Opp K Times}
      case K of road then realitem(kind:road
				   p1:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times})
				   p2:pt(x:{CreateOpp Opp x(1.0 0.0) Times} y:{CreateOpp Opp y(1.0 0.0) Times}))
      [] building then realitem(kind:building
				p1:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times})
				p2:pt(x:{CreateOpp Opp x(0.0 1.0) Times} y:{CreateOpp Opp y(0.0 1.0) Times})
				p3:pt(x:{CreateOpp Opp x(1.0 1.0) Times} y:{CreateOpp Opp y(1.0 1.0) Times})
				p4:pt(x:{CreateOpp Opp x(1.0 0.0) Times} y:{CreateOpp Opp y(1.0 0.0) Times})
			       )
      [] water then  realitem(kind:water
			      	p1:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times})
				p2:pt(x:{CreateOpp Opp x(0.0 1.0) Times} y:{CreateOpp Opp y(0.0 1.0) Times})
				p3:pt(x:{CreateOpp Opp x(1.0 1.0) Times} y:{CreateOpp Opp y(1.0 1.0) Times})
				p4:pt(x:{CreateOpp Opp x(1.0 0.0) Times} y:{CreateOpp Opp y(1.0 0.0) Times})
			     )
      [] pokemon then pokeitem(kind:pokemon  position:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times}))
      [] pokestop then pokeitem(kind:pokestop position:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times}))
      [] arena then pokeitem(kind:arena position:pt(x:{CreateOpp Opp x(0.0 0.0) Times} y:{CreateOpp Opp y(0.0 0.0) Times}))
      else nil
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
      [] rotate(T) then
	 case Point of x(X1 Y1) then
	    {CreateOpp T x(plus(mult(X1 cos(T)) mult(Y1 sin(T))) minus(mult(Y1 cos(T)) mult(X1 sin(T)))) Times}
	 [] y(X1 Y1) then
	    {CreateOpp T x(plus(mult(X1 cos(T)) mult(Y1 sin(T))) minus(mult(Y1 cos(T)) mult(X1 sin(T)))) Times}
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
	 fun{BuildFunc Opp K}
   fun{$ Times} {Create Opp  K Times}  end
end

	 fun{Determine Ru Opp}
   case Ru of H|T then
      case H of primitive(kind:K) then
	 {BuildFunc Opp K}
	 |{Determine T Opp}
      [] translate(dx:X dy:Y 1:RU) then
	 {Determine RU trans(X Y)|Opp}
	 |{Determine T Opp}
      [] scale(rx:X ry:Y 1:RU) then
	 {Determine RU scale(X Y)|Opp}
	 |{Determine T Opp}
      [] rotate(angle:Theta 1:RU) then
	 {Determine RU rotate(Theta)|Opp}
	 |{Determine T Opp}
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
