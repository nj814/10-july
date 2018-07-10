blockset = newDS()
blockset:add{"powerdns.org", "xxx"}

dropset = newDS();
dropset:add("web.de")

malwareset = newDS()
malwareset:add{"com.", "top.", "tk."}

magic2 = newDN("www.magic2.com")

function preresolve(dq)

  pdnslog("prereesolve handler called for: "..dq.remoteaddr:toString().. ", local: ".. dq.localaddr:toString()..", ".. dq.qname:toString()..", ".. dq.qtype)
  
  if dropset:check(dq.qname) then
    dq.rcode = pdns.DROP  
    return true;
  end

  if malwareset:check(dq.qname) then
      dq.rcode = pdns.NXDOMAIN
      return true;
   end        
        
	return false; 
end


--[[ function postresolve(dq)
	--- pdnslog("postresolve called for ",dq.qname:toString())
	--- return true
end]]--
