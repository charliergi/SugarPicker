%====INFORMATION====%
% LFSAB1402 Projet 2016
% Nomas : NOMA1-NOMA2
% Noms : (Nom1,Prenom1)-(Nom2,Prenom2)
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
   Extensions = opt(withExtendedFormula:false
		    withIfThenElse:false
		    withComparison:false
		    withTimeWindow:false
		    withCheckMapEasy:false
		    withCheckMapComplete:false
		   )
in
   Map = map(ru: [translate(dx:plus(10.0 10.0) dy:10.0 1:[scale(rx:10.0 ry:10.0 1:[primitive(kind:road) primitive(kind:road)])])] pu:/*[translate(dx:time dy:100.0 1:[primitive(kind:pokemon)])]*/ nil) %% TODO change the map here
% Prends une liste de Ru en paramètre
% Si le record traité est une primitive, alors le record est traité avec ses opérations précédentes dans le bon ordre, et est joint à la suite des autres records.
% Sinon, selon le record traité, effectue des opérations correspondantes sur les coordonnées de la future primitive traitée. -- OK
   
   fun{MyFunction Map}
      local Determine Create Separate Reorganise BuildFunc Calculate GetTime in 
	 % Lance la fonction Determine sur la liste Ru et Pu de la map. -- OK
	 
	 fun{Separate Map}
	    case Map of nil then nil
	    [] map(ru:Ru pu:Pu) then
	       local I1 I2 Time in
		  I1={Determine Ru 0.0 0.0 0.0 1.0 1.0 1.0 1.0 0.0 0.0}
		  I2={Determine Pu 0.0 0.0 0.0 1.0 1.0 1.0 1.0 0.0 Time}
		  {Append {BuildFunc {Reorganise I1} Time} {BuildFunc {Reorganise I2} Time}}
	       end
	    end
	 end

	 
	 fun{Determine Ru Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 Time}
	    case Ru of H|T then
	       case H of primitive(kind:K) then
		  {Create Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 K}|{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 Time}
	       [] translate(dx:X dy:Y 1:RU) then
		  local X1 Y1 in
		     X1={Calculate X Time}
		     Y1={Calculate Y Time}
		     {Determine RU Dx1+X1 Dy1+Y1 Dx2+X1 Dy2+Y1 Dx3+X1 Dy3+Y1 Dx4+X1 Dy4+Y1 Time}|{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 Time}
		  end
	       [] scale(rx:X ry:Y 1:RU) then
		  local X1 Y1 in
		     X1={Calculate X Time}
		     Y1={Calculate Y Time}
		     {Determine RU Dx1*X1 Dy1*Y1 Dx2*X1 Dy2*Y1 Dx3*X1 Dy3*Y1 Dx4*X1 Dy4*Y1 Time}|{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 Time}
		  end
	       [] rotate(angle:Theta 1:RU) then
		  {Determine
		   RU
		   (Dx1*{Float.cos Theta}+Dy1*{Float.sin Theta}) (Dy1*{Float.cos Theta}-Dx1*{Float.sin Theta})
		   (Dx2*{Float.cos Theta}+Dy2*{Float.sin Theta}) (Dy2*{Float.cos Theta}-Dx2*{Float.sin Theta})
		   (Dx3*{Float.cos Theta}+Dy3*{Float.sin Theta}) (Dy3*{Float.cos Theta}-Dx3*{Float.sin Theta})
		   (Dx4*{Float.cos Theta}+Dy4*{Float.sin Theta}) (Dy4*{Float.cos Theta}-Dx4*{Float.sin Theta})
		   Time
		  }
	       else nil
	       end
	    else nil
	    end
	 end
% Cree le record avec ses coordonnees selon son type (kind) -- OK
	 fun{Create Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 K}
	    case K of road then realitem(kind:road p1:pt(x:Dx1 y:Dy1) p2:pt(x:Dx4 y:Dy4))
	    [] building then realitem(kind:building
				      p1:pt(x:Dx1 y:Dy1)
				      p2:pt(x:Dx2 y:Dy2)
				      p3:pt(x:Dx3 y:Dy3)
				      p4:pt(x:Dx4 y:Dy4)
				     )
	    [] water then  realitem(kind:water
				    p1:pt(x:Dx1 y:Dy1)
				    p2:pt(x:Dx2 y:Dy2)
				    p3:pt(x:Dx3 y:Dy3)
				    p4:pt(x:Dx4 y:Dy4)
				   )
	    [] pokemon then pokeitem(kind:pokemon  position:pt(x:Dx1 y:Dy1))
	    [] pokestop then pokeitem(kind:pokestop position:pt(x:Dx1 y:Dy1))
	    [] arena then pokeitem(kind:arena position:pt(x:Dx1 y:Dy1))
	    else nil
	    end
	 end
	 
	 fun{Calculate Data Time}
	    case Data of time then Time
	    [] plus(X Y) then
	       {Calculate X Time} + {Calculate Y Time}
	    [] minus(X Y) then
	       {Calculate X Time} - {Calculate Y Time}
	    [] mult(X Y) then
	       {Calculate X Time} * {Calculate Y Time}
	    []'div'(X Y) then
	       {Calculate X Time} / {Calculate Y Time}
	    [] sin(X) then
	       case X of time then
		  {Float.sin Time}
	       else
		  {Float.sin {Calculate X Time}}  
	       end
	    [] cos(X) then
	       case X of time then
		  {Float.cos Time}
	       else
		  {Float.cos {Calculate X Time}}  
	       end
	    [] tan(X) then
	       case X of time then
		  {Float.tan Time}
	       else
		  {Float.tan {Calculate X Time}}  
	       end
	    [] exp(X) then
	       case X of time then 
		  {Float.exp Time}
	       else
		  {Float.exp {Calculate X Time}}
	       end
	    [] log(X) then
	       case X of time then 
		  {Float.log Time}
	       else
		  {Float.log {Calculate X Time}}
	       end
	    [] neg(X) then
	       ~{Calculate X Time}
	    [] ite(X Y Z) then
	       if {Calculate X Time} == 0.0 then
		  {Calculate Z Time}
	       else
		  {Calculate Y Time}
	       end
	    [] eq(X Y) then
	       if {Calculate X Time} == {Calculate Y Time} then
		  1.0
	       else
		  0.0
	       end
	    [] ne(X Y) then
	       if {Calculate X Time} == {Calculate Y Time} then
		  0.0
	       else
		  1.0
	       end
	    [] lt(X Y) then
	       if {Calculate X Time} < {Calculate Y Time} then
		  1.0
	       else
		  0.0
	       end
	    [] le(X Y) then
	       if {Calculate X Time} =< {Calculate Y Time} then
		  1.0
	       else
		  0.0
	       end
	     [] gt(X Y) then
	       if {Calculate X Time} > {Calculate Y Time} then
		  1.0
	       else
		  0.0
	       end
	     [] ge(X Y) then
	       if {Calculate X Time} >= {Calculate Y Time} then
		  1.0
	       else
		  0.0
	       end 
	       
	    else
	       Data
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
% Place le record dans la fonction annonyme récursivement jusqu'à épuisement de la liste -- OK
	 
	 fun{BuildFunc L Time}
	    case L of nil then nil
	    [] H|T then
	       fun{$ Time} H end|{BuildFunc T Time}
	    end
	 end

	 

	 

	 {Separate Map}
      end
   end
   
   fun{CheckMap Map}
      false %% TODO complete here the function for the checking of the maps
   end
   
   {Projet.run MyFunction Map MaxTime Extensions CheckMap}
end