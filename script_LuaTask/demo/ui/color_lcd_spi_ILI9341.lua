--- 模块功能：ILI 9341驱动芯片LCD命令配置
-- @author openLuat
-- @module ui.color_lcd_spi_ili9341
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.27

--[[
注意：此文件的配置，硬件上使用的是LCD专用的SPI引脚，不是标准的SPI引脚
disp库目前仅支持SPI接口的屏，硬件连线图如下：
Air模块 LCD
GND--地
SPI_CS--片选
SPI_CLK--时钟
SPI_DO--数据
SPI_DI--数据/命令选择
VDDIO--电源
UART1_CTS--复位
]]

module(...,package.seeall)

--[[
函数名：init
功能  ：初始化LCD参数
参数  ：无
返回值：无
]]
local function init()
    local para =
    {
        width = 240, --分辨率宽度，128像素；用户根据屏的参数自行修改
        height = 320, --分辨率高度，160像素；用户根据屏的参数自行修改
        bpp = 16, --位深度，彩屏仅支持16位
        bus = disp.BUS_SPI4LINE, --LCD专用SPI引脚接口，不可修改
        xoffset = 0, --X轴偏移
        yoffset = 0, --Y轴偏移
        freq = 13000000, --spi时钟频率，支持110K到13M（即110000到13000000）之间的整数（包含110000和13000000）
        hwfillcolor = 0xFFFFFF, --填充色，黑色
        pinrst = pio.P0_14, --reset，复位引脚
        pinrs = pio.P0_18, --rs，命令/数据选择引脚
        --初始化命令
        --前两个字节表示类型：0001表示延时，0000或者0002表示命令，0003表示数据
        --延时类型：后两个字节表示延时时间（单位毫秒）
        --命令类型：后两个字节命令的值
        --数据类型：后两个字节数据的值
        initcmd =
        {
            0x11,
            0x00010078,
            0xCF,
            0x00030000,
            0x00030099,
            0x00030030,
            0xED,
            0x00030064,
            0x00030003,
            0x00030012,
            0x00030081,
            0xCB,
            0x00030039,
            0x0003002C,
            0x00030000,
            0x00030034,
            0x00030002,
            0xEA,
            0x00030000,
            0x00030000,
            0xE8,
            0x00030085,
            0x00030000,
            0x00030078,
            0xC0,
            0x00030023,
            0xC1,
            0x00030012,
            0xC2,
            0x00030011,
            0xC5,
            0x00030040,
            0x00030030,
            0xC7,
            0x000300A9,
            0x3A,
            0x00030055,
            0x36,
            0x00030008,
            0xB1,
            0x00030000,
            0x00030018,
            0xB6,
            0x0003000A,
            0x000300A2,
            0xF2,
            0x00030000,
            0xF7,
            0x00030020,
            0x26,
            0x00030001,
            0xE0,
            0x0003001F,
            0x00030024,
            0x00030023,
            0x0003000B,
            0x0003000F,
            0x00030008,
            0x00030050,
            0x000300D8,
            0x0003003B,
            0x00030008,
            0x0003000A,
            0x00030000,
            0x00030000,
            0x00030000,
            0x00030000,
            0xE1,
            0x00030000,
            0x0003001B,
            0x0003001C,
            0x00030004,
            0x00030010,
            0x00030007,
            0x0003002F,
            0x00030027,
            0x00030044,
            0x00030007,
            0x00030015,
            0x0003000F,
            0x0003003F,
            0x0003003F,
            0x0003001F,            
            0x29,
        },
        --休眠命令
        sleepcmd = {
            0x10,
        },
        --唤醒命令
        wakecmd = {
            0x11,
        }
    }
    disp.init(para)
    disp.clear()
    disp.update()
end

--控制SPI引脚的电压域
pmd.ldoset(6,pmd.LDO_VLCD)
init()

--打开背光
--实际使用时，用户根据自己的lcd背光控制方式，添加背光控制代码
--UART1 RTS/GPIO2，用来控制LCD的背光
pio.pin.setdir(pio.OUTPUT,pio.P0_2)
pio.pin.setval(1,pio.P0_2)
