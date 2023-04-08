/*
* ----------------------------- Ports' Definition -----------------------------
* ----------------------------- Inputs -----------------------------
* IN0:    
* IN1:    
* select:          
* 
* ----------------------------- Outputs -----------------------------
* OUT:    
*/


module multiplexer_2x1 (
    input IN0,
    input IN1,
    input select,
    
    output OUT
);

    assign OUT = select ? IN1 : IN0;

endmodule