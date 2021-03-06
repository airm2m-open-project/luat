--- 模块功能：MQTT客户端数据接收处理
-- @author openLuat
-- @module default.linkInMsg
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.20

module(...,package.seeall)

--- MQTT客户端数据接收处理
-- @param mqttClient，MQTT客户端对象
-- @return 处理成功返回true，处理出错返回false
-- @usage linkInMsg.proc(mqttClient)
function proc(mqttClient)
    local r,data
    while true do
        r,data = mqttClient:receive(2000)
        --接收到数据
        if r and data~="timeout" then
            log.info("linkInMsg.proc",data.topic,string.toHex(data.payload))
                
            --TODO：根据需求自行处理data.payload
            
            --如果linkOutMsg中有等待发送的数据，则立即退出本循环
            if linkOutMsg.waitForSend() then return true end
        else
            break
        end
    end
	
    return data=="timeout" or r
end
