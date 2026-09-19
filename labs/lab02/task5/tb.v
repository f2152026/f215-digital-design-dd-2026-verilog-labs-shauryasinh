module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;

  wire [3:0] t_result;

  integer i,j,k;
  integer errors;

  reg [3:0] expected;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  // Waveform dump
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin

    errors = 0;

    for(k=0;k<2;k=k+1) begin
      for(i=0;i<16;i=i+1) begin
        for(j=0;j<16;j=j+1) begin

          t_op = k;
          t_a  = i;
          t_b  = j;

          #1;

          if(t_op == 0)
            expected = i + j;
          else
            expected = i - j;

          if(t_result !== expected) begin

            $display(
              "FAIL op=%b a=%d b=%d got=%d expected=%d",
              t_op,t_a,t_b,t_result,expected
            );

            errors = errors + 1;

          end

        end
      end
    end

    $display("Errors = %0d", errors);

    $finish;

  end

endmodule