module fifo(
    input r_en,
    input clk1,
    input w_en,
    input clk,
    input rst,
    input [7:0] data_in,
    
    output reg [7:0] data_out,
    output full,
    output empty
);

reg [7:0] mem [0:255] ;
reg [7:0] head,tail;
integer i;

always @(posedge clk or posedge rst)begin
    if(rst)begin
        head <= 8'b0;
        tail <= 8'b0;
        for(i = 0; i < 256; i=i+1)
            mem[i] <= 0;
    end else if(w_en && full == 0)begin
        mem[head] <= data_in;
        head <= head + 1;
    end 
end

always @(posedge clk1 )begin
    if(r_en && empty == 0)begin
        data_out <= mem[tail];
        tail <= tail + 1;
    end
end
assign full = (head + 1'b1 == tail) ? 1'b1:1'b0;
assign empty = (head == tail) ? 1'b1:1'b0;
endmodule

        