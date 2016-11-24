declare
fun{Determine Ru Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4}
   case Ru of H|T then
      case H of primitive(kind:K) then
	 {Create Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4 K}|{Determine T Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4}
      [] translate(dx:X dy:Y 1:Ru) then
	 {Determine Ru Dx1+X Dy1+Y Dx2+X Dy2+Y Dx3+X Dy3+Y Dx4+X Dy4+Y}|{Determine Y Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4}
      [] scale(rx:X ry:Y 1:Ru) then
	 {Determine Ru Dx1*X Dy1*Y Dx2*X Dy2*Y Dx3*X Dy3*Y Dx4*X Dy4*Y}|{Determine Y Dx1 Dy1 Dx2 Dy2 Dx3 Dy3 Dx4 Dy4}
      [] rotate(angle:Theta 1:Ru) then
	 {Determine
	  Ru
	  (Dx1*{Float.cos Theta}+Dy1*{Float.sin Theta}) (Dy1*{Float.cos Theta}-Dx1*{Float.sin Theta})
	  (Dx2*{Float.cos Theta}+Dy2*{Float.sin Theta}) (Dy2*{Float.cos Theta}-Dx2*{Float.sin Theta})
	  (Dx3*{Float.cos Theta}+Dy3*{Float.sin Theta}) (Dy3*{Float.cos Theta}-Dx3*{Float.sin Theta})
	  (Dx4*{Float.cos Theta}+Dy4*{Float.sin Theta}) (Dy4*{Float.cos Theta}-Dx4*{Float.sin Theta})
	 }
      else nil
      end
   else nil
   end
end
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
   else nil
   end
end
fun{Reorganise L}
   case L of H|T then
      case H of H1|T1 then
	 {Append {Reorganise H} T}
	 else H|{Reorganise T}
      end
   else L
   end
end
fun{BuildFunc L}
   case L of nil then nil
   [] H|T then
      fun{$ Time} H end|{BuildFunc T}
   end
end
fun{Separate Map}
   case Map of nil then nil
   [] map(ru:Ru pu:Pu) then
      local I1 in
	 I1={Determine Ru 0.0 0.0 0.0 1.0 1.0 1.0 1.0 0.0}
	 {BuildFunc {Reorganise I1}}
      end
   end
end



{Browse  {Separate map(ru: [translate(dx:10.0 dy:10.0 1:[scale(rx:10.0 ry:10.0 1:[primitive(kind:road)])])] pu:nil)}}




