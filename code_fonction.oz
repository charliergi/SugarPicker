%====INFORMATION====%
% LFSAB1402 Projet 2016
% Nomas : NOMA1-NOMA2
% Noms : (Nom1,Prenom1)-(Nom2,Prenom2)
%====MODULELINK====%
declare
[Projet]={Module.link ["/home/alexandre/Bureau/info2_projet/Projet2016.ozf"]}

%====CODE====%
local
   MaxTime = 10 % nombre de frame à l'animation
   MyFunction
   Map
   CheckMap
   GenerateMap
   Extensions = opt(withExtendedFormula:false
		    withIfThenElse:false
		    withComparison:false
		    withTimeWindow:false
		    withCheckMapEasy:false
		    withCheckMapComplete:false
		   )
   
in
   Map = map(ru:nil pu:nil) %% TODO change the map here
   
   fun{MyFunction Map }
      local Search Change Create BuildFunc Separate in
	 fun{Separate Map Acc1 Acc2}
	    case Map of nil then nil
	    [] map(ru:Ru pu:Pu) then
	       Acc1={Search Ru nil}
	       Acc2={Search Pu nil}
	       {Append Acc1 Acc2}
	    end
	 end
	 
	 fun{Search RU Acc}
	       case RU of nil then Acc
	       [] X|Y then {Search Y {BuildFunc}|Acc}
	       end
	    end
	 end
	 fun{BuildFunc R}
	    fun{$ Time}
	       {Change R 0 0 0 0}
	    end
	 end
	 fun{Change Ru Rx Ry Dx Dy}  
	       case Ru of nil then nil
	       [] primitive(kind=K) then {Create Ru Rx Ry Dx Dy}
	       [] scale(rx:RX ry:RY 1:RU) then {Change RU RX RY Dx Dy}
	       [] translate(dx:DX dy:DY 1:RU) then {Change RU Rx Ry DX DY}
	       end 
	 end
	 fun{Create Ru Rx Ry Dx Dy }
	    
	    case Ru of nil then nil
	    [] primitive(kind:K) then
	       if K == road then realitem(kind:road p1:pt(x:Rx*(0+Dx) y:Ry*(0+Dy)) p2:pt(x:Rx*(1+Dx) y:Ry*(0+Dy))
		elseif K== building then realitem(kind:building p1:pt(x:Rx*(0+Dx) y:Ry*(0+Dy)) p2:pt(x:Rx*(1+Dx) y:Ry*(0+Dy)) p3:pt(x:Rx*(1+Dx) y:Ry*(1+Dy)) p4:pt(x:Rx*(1+Dx) y:Ry*(1+Dy)))			   
		end
	    end
	 end
	 
	 end
	
      end
      
										
   end

   fun{CheckMap Map}
      false %% TODO complete here the function for the checking of the maps
   end
   
   {Projet.run MyFunction Map MaxTime Extensions CheckMap}
end
