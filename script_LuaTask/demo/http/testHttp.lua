--- 模块功能：HTTP功能测试.
-- @author openLuat
-- @module http.testHttp
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.23

module(...,package.seeall)

require"http"

local function cbFnc(result,prompt,head,body)
    log.info("testHttp.cbFnc",result,prompt)
    if result and head then
        for k,v in pairs(head) do
            log.info("testHttp.cbFnc",k..": "..v)
        end
    end
    if result and body then
        log.info("testHttp.cbFnc","bodyLen="..body:len())
    end
end

local function cbFncFile(result,prompt,head,filePath)
    log.info("testHttp.cbFncFile",result,prompt,filePath)
    if result and head then
        for k,v in pairs(head) do
            log.info("testHttp.cbFncFile",k..": "..v)
        end
    end
    if result and filePath then
        log.info("testHttp.cbFncFile","fileSize="..io.fileSize(filePath))
        
        --输出文件内容，如果文件太大，一次性读出文件内容可能会造成内存不足，分次读出可以避免此问题
        if size<=4096 then
            plog.info("testHttp.cbFncFile",filehandle:read("*all"))
        else
			
        end
    end
    --文件使用完之后，如果以后不再用到，需要自行删除
    if filePath then os.remove(filePath) end
end

http.request("GET","www.lua.org",nil,nil,nil,nil,cbFnc)
--http.request("GET","https://www.baidu.com",{caCert="ca.crt"},nil,nil,nil,cbFnc)
--http.request("GET","www.lua.org",nil,nil,nil,30000,cbFncFile,"download.bin")
--http.request("GET","http://www.lua.org",nil,nil,nil,30000,cbFnc)
--http.request("GET","www.lua.org/about.html",nil,nil,nil,30000,cbFnc)
--http.request("GET","www.lua.org:80/about.html",nil,nil,nil,30000,cbFnc)
--http.request("POST","www.iciba.com",nil,nil,"Luat",30000,cbFnc)
--http.request("POST","36.7.87.100:6500",nil,{head1="value1"},{[1]="begin\r\n",[2]={file="/lua/http.lua"},[3]="end\r\n"},30000,cbFnc)
