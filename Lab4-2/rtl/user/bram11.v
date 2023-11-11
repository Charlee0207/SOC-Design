module bram11(
    CLK,
    WE0,
    EN0,
    Di0,
    Do0,
    A0
);

    input   wire            CLK;
    input   wire    [3:0]   WE0;
    input   wire            EN0;
    input   wire    [31:0]  Di0;
    output  wire     [31:0]  Do0;
    input   wire    [11:0]   A0;

    // 16 kB
    //parameter N = 12;
    (* ram_style = "block" *) reg [31:0] RAM[0:10];
    //reg [31:0] RAM[0:2**N-1]

    reg [11:0] r_A;

    always @(posedge CLK) begin
        r_A <= A0;
    end

    assign Do0 = {32{EN0}} & RAM[r_A>>2];    // read

    reg [31:0] Temp_D;
    always @(posedge CLK) begin
        if(EN0) begin
	    if(WE0[0]) RAM[A0>>2][7:0] <= Di0[7:0];
            if(WE0[1]) RAM[A0>>2][15:8] <= Di0[15:8];
            if(WE0[2]) RAM[A0>>2][23:16] <= Di0[23:16];
            if(WE0[3]) RAM[A0>>2][31:24] <= Di0[31:24];
        end
    end
endmodule