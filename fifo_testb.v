`timescale 1ps/1ps

module tb_fifo;
    reg clk,rst,r_en,w_en,clk1;
    wire [7:0]data_out;
    wire full, empty;
    reg [7:0] data_in;

    fifo fifo(
        .clk(clk),
        .clk1(clk1),
        .r_en(r_en),
        .rst(rst),
        .w_en(w_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial clk1 = 0;
    always #1 clk1 = ~clk1;

    
initial begin
    $dumpfile("sc.vcd");
    $dumpvars(0, tb_fifo);

    rst = 1;
    r_en = 0;
    w_en = 0;
    data_in = 8'b0;

    repeat (2) @(negedge clk);

    rst = 0;
    data_in = 8'b10101010;
    w_en = 1;

    @(negedge clk);

    data_in = 8'b11001011;

    @(negedge clk);

    data_in = 8'b11010100;

    @(negedge clk);

    data_in = 8'b11011101;

    @(negedge clk);

    data_in = 8'b11010110;

    @(negedge clk);

    r_en = 1;
    w_en = 0;

    @(negedge clk1);
    w_en = 0;
    $finish;
end

    
endmodule