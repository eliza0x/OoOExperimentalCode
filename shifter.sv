module shifter(
    input  int in[16],
    input  bit  used[$size(in)],
    output int out[$size(in)]
);

    `define SIMULATE
    `ifdef SIMULATE
    initial begin
        for (int i=0; i<$size(in); i++) begin
            in[i]   <= i;
            used[i] <= 1'b1 & i;
        end

        #1;
         
        $write("in  : ");
        foreach (in[i]) $write("%3d", in[i]);
        $write("\nused: ");
        foreach (in[i]) $write("%3d", used[i]);
        $write("\n--------------------\nout : ");
        foreach (out[i]) $write("%3d", out[i]);
        $write("\nused: ");
        foreach (in[i]) $write("%3d", used[i]);
        $display("");
    end
    `endif

    Sort sort(.*);
endmodule

module Sort(
    input  int in[16],
    input  bit used[$size(in)],
    output int out[$size(in)]
);

    assign out = sort(in, used);

    // unpackedの配列を返すのはtypedefを使わないと出来無い？
    typedef int Arr[16];
    function Arr sort(int in[16], bit key[$size(in)]);
        byte tmp_in;
        bit tmp_key;
        for (byte l=$size(in)-1; l!=0; l--) begin
            for (byte i=0; i<l; i++) begin
                if (key[i] == 0) begin
                    tmp_in  = in[i+0];
                    in[i+0] = in[i+1];
                    in[i+1] = tmp_in;

                    tmp_key  = key[i+0];
                    key[i+0] = key[i+1];
                    key[i+1] = tmp_key;
                end
            end
        end
        sort = in;
    endfunction
endmodule

