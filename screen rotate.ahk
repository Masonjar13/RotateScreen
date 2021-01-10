#singleInstance force
#noEnv
display:="\\.\DISPLAY1"
lookup:={"^!down":[0,0],"^!right":[1,1],"^!up":[2,0],"^!left":[3,1]}
return

^!down::
^!right::
^!up::
^!left::

if (lookup[a_thisHotkey][2]){ ; rotating to portrait
	sRes:=strSplit((cRes:=screenRes_Get(display)),["x","@"])
	if (sRes[2] < sRes[1]) {
		cRes:=sRes[2] "x" sRes[1] "@" sRes[3]
	}
} else { ; rotating to landscape
	sRes:=strSplit((cRes:=screenRes_Get(display)),["x","@"])
	if (sRes[2] > sRes[1]) {
		cRes:=sRes[2] "x" sRes[1] "@" sRes[3]
	}
 }
screenRes_Set(cRes,display,lookup[a_thisHotkey][1])
return

screenRes_Set(WxHaF, Disp:=0, orient:=0) {       ; v0.90 By SKAN on D36I/D36M @ tiny.cc/screenresolution ; edited orientation in by Masonjar13
	Local DM, N:=VarSetCapacity(DM,220,0), F:=StrSplit(WxHaF,["x","@"],A_Space)
	Return DllCall("ChangeDisplaySettingsExW",(Disp=0 ? "Ptr" : "WStr"),Disp,"Ptr",NumPut(F[3],NumPut(F[2],NumPut(F[1]
	,NumPut(32,NumPut(0x5C0080,NumPut(220,NumPut(orient,DM,84,"UInt")-20,"UShort")+2,"UInt")+92,"UInt"),"UInt")
	,"UInt")+4,"UInt")-188, "Ptr",0, "Int",0, "Int",0)  
}
screenRes_Get(Disp:=0) {              ; v0.90 By SKAN on D36I/D36M @ tiny.cc/screenresolution
	Local DM, N:=VarSetCapacity(DM,220,0) 
	Return DllCall("EnumDisplaySettingsW", (Disp=0 ? "Ptr" : "WStr"),Disp, "Int",-1, "Ptr",&DM)=0 ? ""
		: Format("{:}x{:}@{:}", NumGet(DM,172,"UInt"),NumGet(DM,176,"UInt"),NumGet(DM,184,"UInt")) 
}
