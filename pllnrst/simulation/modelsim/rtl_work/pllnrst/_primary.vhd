library verilog;
use verilog.vl_types.all;
entity pllnrst is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sysrst_n        : out    vl_logic
    );
end pllnrst;
