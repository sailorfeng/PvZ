-- ����״̬��
-- by f.f.

-- obj: ִ�е�PzObj
-- conf: ��Ӧclass�Ĳ��ԣ���ʽ����
-- {
-- 	STATE1={ 	
-- 				judge_func1_1, -- ״̬��ת����1�����ؽ����״̬������nil��ʾ����֮����ж�
-- 				judge_func1_2, -- ״̬��ת����2�����ؽ����״̬
-- 				judge_func1_3, -- ״̬��ת����3�����ؽ����״̬
-- 				...  -- ��ת���������ȼ�����λ�þ���
-- 				deal:state_func1, -- ������
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
	for i=1, #conf[ls] do  -- �����ת�����ж�
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
