declare
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
	       if {CheckFormule Rx} andthen {CheckFormule Ry} then {CheckRu Ru}
	       else false
	       end
	    [] translate(dx:Dx dy:Dy 1:Ru ) then
	       if {CheckFormule Dx} andthen {CheckFormule Dy} then {CheckRu Ru}
	       else false
	       end
	    [] rotate(angle:Theta 1:Ru) then
	       if {CheckFormule Theta} then {CheckRu Ru}
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
	       if {CheckFormule Dy} andthen {CheckFormule Dx} then {CheckPu Pu}
	       else false
	       end
	    else false
	    end
	 else false
	 end
      end
      fun{CheckFormule F}
	 if {Float.is F} then true
	 else
	    case time of F then true
	    [] plus(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] minus(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] mult(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] 'div'(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] sin(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    [] cos(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    [] tan(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    end
	 end
      end
      case Map of nil then false
      [] map(ru:Ru pu:Pu) then
	    if {CheckList Ru ru} andthen {CheckList Pu pu} then true
	    else false
	    end
      else false
      end	 
   end
end
Map = map(ru:[rotate(angle:1.6 1:[scale(rx:cos(sin(10.0)) ry:100.0 1:[translate(dx:250.0 dy:250.0 1:[primitive(kind:road) primitive(kind:road)])])])] pu:[translate(dx:time dy:cos(sin(10.0)) 1:[primitive(kind:pokemon) primitive(kind:pokestop)])])

{Browse {CheckMap Map}}