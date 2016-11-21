%====INFORMATION====%
% LFSAB1402 Projet 2016
% Nomas : NOMA1-NOMA2
% Noms : (Nom1,Prenom1)-(Nom2,Prenom2)
%====MODULELINK====%
declare
[Projet]={Module.link ["/home/gilles/Desktop/UCL/INFO_2/PROJET/ProjetOz2016/Projet2016.ozf"]}

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
   /*Map = map(
	    ru:[scale(
		    rx:0.2
		    ry:0.2
		    1:[primitive(kind:water)])
		primitive(kind:road)
		primitive(kind:building)]
	      pu:nil)*/
   
   Map = map(ru:nil pu:nil)
   
   fun{MyFunction Map}
      % parcourir le ru et pu de la map en paramètre
      % définir les différents cas possibles:
      % ru :
      % primitive, scale, rotate, translate
      % pu : translate et primitive
      % /!\ d'abord ru epuis pu.
      % [primitive(kind:water) pimitive(kind:building)]
      local Add Change in
	 fun{Change Atome RI Ax Ay}
	    %applique un changement sur le realitem suivant atome 
	    case RI of nil then %%
	    [] realitem.kind==road then
	       case realitem(kind:K p1:P1 p2:P2)
	Add=[fun{$ Time} realitem(kind:water
			     p1:pt(x:127.0 y:1.0)
			     p2:pt(x:0.0 y:450.0)
			     p3:pt(x:300.0 y:450.0)
			     p4:pt(x:450.0 y:300.0))
	   
	     end
	     fun{$ Time} realitem(kind:road
			     p1:pt(x:100.0 y:100.0)
			     p2:pt(x:200.0 y:200.0))
	     end
	
	     fun{$ Time} realitem(kind:building
			     p1:pt(x:150.0 y:150.0)
			     p2:pt(x:150.0 y:250.0)
			     p3:pt(x:250.0 y:250.0)
			     p4:pt(x:250.0 y:150.0))
	     end
	
	     fun{$ Time} pokeitem(kind:pokemon position:pt(x:250.0 y:250.0))
	     end
       
       
	    ]
	 case Map of nil then nil
	 [] map(ru:Ru pu:Pu) then
	    case Ru of nil then
	       case Pu of nil then Add
		  %[]%
	       end
	    [] scale(rx:Rx ry:Ry 1:LP)
	       case LP of H|T then
		  case H of primitive(kind:K) then
		     {Change '*' H nil Rx Ry}
		  end
	       end
	    end
	 end
	 
	 end%% TODO complete your function here
   end

   fun{CheckMap Map}
      false %% TODO complete here the function for the checking of the maps
   end
   
   {Projet.run MyFunction Map MaxTime Extensions CheckMap}
end
