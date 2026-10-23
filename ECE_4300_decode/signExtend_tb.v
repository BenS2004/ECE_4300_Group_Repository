module signExtend_tb();

    reg [15:0] immediate;
    wire [31:0] extended;

    signExtend s0(.immediate(immediate), .extended(extended));

    initial begin
        $dumpfile("SignExtendTestBenchWaveForm");
        $dumpvars(0, signExtend_tb);
        immediate = 16'h0;
        $display("immediate: hex: %h, decimal: %d", immediate, $signed(immediate));
        #10;
        $display("extended: hex: %h, decimal: %d", extended, $signed(extended));
        immediate = 16'h000d;
        $display("immediate: hex: %h, decimal: %d", immediate, $signed(immediate));
        #10;
        $display("extended: hex: %h, decimal: %d", extended, $signed(extended));
        immediate = 16'h0019;
        $display("immediate: hex: %h, decimal: %d", immediate, $signed(immediate));
        #10;
        $display("extended: hex: %h, decimal: %d", extended, $signed(extended));
        immediate = 16'h002b;
        $display("immediate: hex: %h, decimal: %d", immediate, $signed(immediate));
        #10;
        $display("extended: hex: %h, decimal: %d", extended, $signed(extended));
        immediate = 16'hffbb;
        $display("immediate: hex: %h, decimal: %d", immediate, $signed(immediate));
        #10;
        $display("extended: hex: %h, decimal: %d", extended, $signed(extended));
        immediate = 16'hffa8;
        $display("immediate: hex: %h, decimal: %d", immediate, $signed(immediate));
        #10;
        $display("extended: hex: %h, decimal: %d", extended, $signed(extended));
        immediate = 16'hfff2;
        $display("immediate: hex: %h, decimal: %d", immediate, $signed(immediate));
        #10;
        $display("extended: hex: %h, decimal: %d", extended, $signed(extended));
        $finish;
        
    end

endmodule