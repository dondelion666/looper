old_rec=0
old_pre=0

function init()

for i=1,4 do
  softcut.enable(i,0)
  softcut.level_input_cut(1,i,1)
  softcut.play(i,1)
  softcut.rec(i,1)
  softcut.buffer(i,1)
  softcut.position(i,1)
end

for i=1,4 do
  params:add_separator("voice"..i,"voice"..i)
  params:add_control("start"..i,"start"..i,controlspec.new(1,10,'lin',0.01,1,'s',0.01))
  params:set_action("start"..i,function(x) softcut.loop_start(i,x) end)
  params:add_control("end"..i,"end"..i,controlspec.new(1,10,'lin',0.01,3,'s',0.01))
  params:set_action("end"..i,function(x) softcut.loop_end(i,x) end)
  params:add_number("rate"..i,"rate"..i,-64,64,0)
  params:set_action("rate"..i, function(x) softcut.rate(i,interval_to_ratio(x)) end)
  params:add_binary("looping"..i,"looping"..i,"toggle",1)
  params:set_action("looping"..i,function (x) softcut.loop(i,x) end)
  params:add_control("rec_level"..i,"rec_level"..i,controlspec.new(0,1,'lin',0.01,0,'s',0.01))
  params:set_action("rec_level"..i,function(x) softcut.rec_level(i,x) end)
  params:add_control("pre_level"..i,"pre_level"..i,controlspec.new(0,1,'lin',0.01,0,'s',0.01))
  params:set_action("pre_level"..i,function(x) softcut.pre_level(i,x) end)
  params:add_control("out_level"..i,"out_level"..i,controlspec.new(0,1,'lin',0.01,0,'s',0.01))
  params:set_action("out_level"..i,function(x) softcut.level(i,x) end)
  params:add_binary("hold"..i,"hold"..i,"toggle",0)
  params:set_action("hold"..i,function(x) hold(i,x) end)
  params:add_binary("reset"..i,"reset"..i,"trigger",0)
  params:set_action("reset"..i,function() softcut.position(i,params:get("start"..i)) end)
end
  
  params:bang()
  
  softcut.enable(1,1)
  params:set("out_level1",1)
  params:set("pre_level1",0.5)

  

end

function interval_to_ratio(interval)
  return math.pow(2, interval / 12)
end

function hold (i,x)
  if x==1 then
    old_rec=params:get("rec_level"..i)
    old_pre=params:get("pre_level"..i)
    softcut.rec(i,0)
    params:set("rec_level"..i,0) 
    params:set("pre_level"..i,1) 
  elseif x==0 then
    softcut.rec(i,1)
    params:set("rec_level"..i,old_rec)
    params:set("pre_level"..i,old_pre)
  end
end

  

  
  
  
