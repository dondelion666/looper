function init()

  softcut.enable(1,1)
  softcut.level_input_cut(1,1,1)
  softcut.play(1,1)
  softcut.rate(1,1)
  softcut.rec(1,1)
  softcut.buffer(1,1)
  softcut.position(1,1)
  
end


params:add_control("start","start",controlspec.new(1,10,'lin',0.01,0,'s',0.01))
params:set_action("start",function(x) softcut.loop_start(1,x) end)
params:add_control("end","end",controlspec.new(10,10,'lin',0.01,10,'s',0.01))
params:set_action("end",function(x) softcut.loop_end(1,x) end)
params:add_number("looping","looping",0,1,1)
params:set_action("looping",function (x) softcut.loop(1,x) end)
params:add_control("rec_level","rec_level",controlspec.new(0,1,'lin',0.01,1,'s',0.01))
params:set_action("rec_level",function(x) softcut.rec_level(1,x) end)
params:add_control("pre_level","rec_level",controlspec.new(0,1,'lin',0.01,0.5,'s',0.01))
params:set_action("pre_level",function(x) softcut.pre_level(1,x) end)
params:add_control("out_level","rec_level",controlspec.new(0,1,'lin',0.01,1,'s',0.01))
params:set_action("out_level",function(x) softcut.level(1,x) end)

params:bang()
