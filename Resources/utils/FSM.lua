-- 有限状态机
-- by f.f.

-- obj: 执行的PzObj
-- conf: 对应class的策略，格式如下
-- {
-- 	STATE1={ 	
-- 				judge_func1_1, -- 状态跳转函数1，返回进入的状态，返回nil表示继续之后的判断
-- 				judge_func1_2, -- 状态跳转函数2，返回进入的状态
-- 				judge_func1_3, -- 状态跳转函数3，返回进入的状态
-- 				...  -- 跳转函数的优先级由其位置决定
-- 				deal:state_func1, -- 处理函数
-- 			},
--	STATE2={ 	
--				judge_func2_1,
--				judge_func2_2,
-- 				deal:state_func2,
--			},
-- 	...
-- }

module(..., package.seeall)
function run(obj, conf)
	local ls = obj.fsm.lastState
	local ns
	for i=1, #conf[ls] do  -- 逐个跳转函数判断
		ns = conf[ls][i](obj)
		if ns ~= nil then break end
	end
	if ns == nil then ns = ls end
	
--	print("new state"..ns)
	obj.fsm.currState = ns
	if conf[ns].deal ~= nil then
		conf[ns].deal(obj)
	end
	obj.fsm.lastState = ns
end

function set(obj, stat)
	obj.fsm.lastState = obj.fsm.currState or stat
	obj.fsm.currState = stat
end
