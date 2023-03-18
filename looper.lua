old_rec=0
old_pre=0

function init()

for i=1,4 do
  softcut.enable(i,1)
end

  params:add_group("setup","setup",26)
  
  params:add_binary("clear_buffer_1","clear buffer 1","trigger",0)
  params:set_action("clear_buffer_1",function() softcut.buffer_clear_channel(1) end)
  params:add_binary("clear_buffer_2","clear buffer 2","trigger",0)
  params:set_action("clear_buffer_2",function() softcut.buffer_clear_channel(2)end)
  
for i=1,4 do
  params:add_separator("setup_separator"..i,"voice "..i)
  params:add_number("input_channel"..i,"input channel"..i,1,2,1)
  params:set_action("input_channel"..i,function(x) softcut.level_input_cut(x,i,params:get("input_lvl"..i)) end)
  params:add_control("input_lvl"..i,"input_lvl"..i,controlspec.new(0,1,'lin',0.01,0,'',0.01))
  params:set_action("input_lvl"..i,function(x) softcut.level_input_cut(params:get("input_channel"..i),i,x) end)
  params:add_binary("play"..i,"play"..i,"toggle",0)
  params:set_action("play"..i,function(x) softcut.play(i,x) end)
  params:add_binary("rec"..i,"rec"..i,"toggle",0)
  params:set_action("rec"..i,function(x) softcut.rec(i,x) end)
  params:add_number("buffer"..i,"buffer"..i,1,2,1)
  params:set_action("buffer"..i,function(x) softcut.buffer(i,x) end)
end

params:bang()

for i=1,4 do
  params:add_group("voice"..i,"voice"..i,9)
  params:add_control("start"..i,"start",controlspec.new(1,10,'lin',0.01,1,'s',0.01))
  params:set_action("start"..i,function(x) softcut.loop_start(i,x) end)
  params:add_control("length"..i,"length",controlspec.new(0,10,'lin',0.01,3,'s',0.01))
  params:set_action("length"..i,function(x) softcut.loop_end(i,params:get("start"..i)+x) end)
  params:add_number("rate"..i,"rate",-64,64,0)
  params:set_action("rate"..i, function(x) softcut.rate(i,interval_to_ratio(x)) end)
  params:add_binary("looping"..i,"looping","toggle",1)
  params:set_action("looping"..i,function (x) softcut.loop(i,x) end)
  params:add_control("rec_level"..i,"rec_level",controlspec.new(0,1,'lin',0.01,0,'',0.01))
  params:set_action("rec_level"..i,function(x) softcut.rec_level(i,x) end)
  params:add_control("pre_level"..i,"pre_level",controlspec.new(0,1,'lin',0.01,0,'',0.01))
  params:set_action("pre_level"..i,function(x) softcut.pre_level(i,x) end)
  params:add_control("out_level"..i,"out_level",controlspec.new(0,1,'lin',0.01,0,'',0.01))
  params:set_action("out_level"..i,function(x) softcut.level(i,x) end)
  params:add_binary("hold"..i,"hold","toggle",0)
  params:set_action("hold"..i,function(x) hold(i,x) end)
  params:add_binary("reset"..i,"reset","trigger",0)
  params:set_action("reset"..i,function() softcut.position(i,params:get("start"..i)) end)
end
  
  params:bang()
  
  params:add_group("mix_matrix","mix matrix",16)
  
  for i=1,4 do
    params:add_separator("mix_separator"..i,"voice "..i)
    for j=1,4 do
      if  i~=j then
        
        params:add_control("mix_"..i.."_"..j,"mix "..i.."->"..j,controlspec.new(0,1,'lin',0.01,0,'',0.01))
        params:set_action("mix_"..i.."_"..j,function(x) softcut.level_cut_cut(i,j,x) end)
      end
    end
  end
  
  params:bang()
  
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

  

  
  
  
